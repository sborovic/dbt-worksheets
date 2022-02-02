import 'dart:io';

import 'package:app/models/log_entry.dart';
import "package:app/models/skill_node.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';

class SqliteDb {
  SqliteDb._();
  static final SqliteDb _instance = SqliteDb._();
  factory SqliteDb() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    var path = join(await getDatabasesPath(), "app.db");

    var exists = await databaseExists(path);

    if (true) {
      // if (!exists) later on...
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "db_rs.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }

  Future<int> insertSkill(
      {required String tableName,
      required String title,
      required String description,
      required int parentId}) async {
    return await (await db).insert(tableName, {
      SkillNode.columnTitle: title,
      SkillNode.columnDescription: description,
      SkillNode.columnParentId: parentId,
      SkillNode.columnIsLeaf: true,
    });
  }

  Future<List<SkillNode>> getChildrenOf(String tableName, int parentId) async {
    final List<Map<String, dynamic>> maps = await (await db).query(
      tableName,
      columns: [
        SkillNode.columnId,
        SkillNode.columnParentId,
        SkillNode.columnTitle,
        SkillNode.columnDescription,
        SkillNode.columnIsLeaf,
        SkillNode.columnIsDeleted,
      ],
      where:
          '${SkillNode.columnParentId} = ? AND ${SkillNode.columnIsDeleted} = ?',
      whereArgs: [parentId, 0],
    );
    var a = List<SkillNode>.generate(maps.length, (i) {
      return SkillNode.fromMap(maps[i]);
    });
    return a;
  }

  Future<SkillNode> getNodeById(String tableName, int id) async {
    final maps = await (await db).query(
      tableName,
      columns: [
        SkillNode.columnId,
        SkillNode.columnParentId,
        SkillNode.columnTitle,
        SkillNode.columnDescription,
        SkillNode.columnIsLeaf,
      ],
      where: 'id = ?',
      whereArgs: [id],
    );
    var a = SkillNode.fromMap(maps[0]);
    return a;
  }

  Future<bool> hasBeenLogged(String tableName, int id) async {
    return (await (await db).query(LogEntry.logsTableName,
            where:
                '${LogEntry.columnTableName} = ? AND ${LogEntry.columnForeignId} = ?',
            whereArgs: [tableName, id]))
        .isNotEmpty;
  }

  Future<int> deleteSkill(String tableName, int id) async {
    final isPresent = await hasBeenLogged(tableName, id);
    if (isPresent) {
      return (await db).update(
        tableName,
        {SkillNode.columnIsDeleted: 1},
        where: '${SkillNode.columnId} = ?',
        whereArgs: [id],
      );
    } else {
      return await (await db).delete(tableName,
          where: '${SkillNode.columnId} = ?', whereArgs: [id]);
    }
  }

  Future<int> insertIntoLogs(
      int datetime, String tableName, int foreignId) async {
    return await (await db).insert(LogEntry.logsTableName, {
      LogEntry.columnDatetime: datetime,
      LogEntry.columnTableName: tableName,
      LogEntry.columnForeignId: foreignId,
    });
  }

  Future<List<Map<String, Object?>>> selectAll(String tableName) async {
    return await (await db).query(tableName);
  }

  Future<List<Map<String, Object?>>> generateReport(
      String tableName, int datetimeFrom, int datetimeTo) async {
    return (await db).rawQuery('''
  WITH RECURSIVE
    /* Count the number of practice sessions per skill */
    L(foreign_id, count)
      AS
        (SELECT foreign_id, COUNT(*)
          FROM logs
          WHERE table_name = 'mindfulness_worksheet_4a'
          GROUP BY foreign_id),
    /* Use JOIN to add necessary data to L for the initial-select */
    J(id, title, description, parent_id, is_leaf, count)
      AS
        (SELECT M.id, title, description, parent_id, is_leaf, count 
          FROM L
          JOIN mindfulness_worksheet_4a AS M ON M.id = L.foreign_id),
    /* Add parent nodes */
    P(id, title, description, parent_id, is_leaf, count)
      AS 
        (SELECT * FROM J
        UNION
        SELECT M.id, M.title, M.description, M.parent_id, M.is_leaf, NULL
          FROM P, mindfulness_worksheet_4a as M
          WHERE M.id = P.parent_id),
    /* Do inorder traversal */
    T(id, title, description, parent_id, is_leaf, count, level)
      AS
        (SELECT *, 0 FROM P WHERE parent_id IS NULL
        UNION
        SELECT P.id, P.title, P.description, P.parent_id, P.is_leaf, P.count, level+1
          FROM T, P
          WHERE T.id = P.parent_id
        ORDER BY id)
	SELECT * FROM T;
  ''');
  }
}
