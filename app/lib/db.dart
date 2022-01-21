import 'dart:io';

import "package:app/models/skill_node.dart";
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

    if (exists) {
      // if (!exists) later on...
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "db_en.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    return await openDatabase(path);
  }

  Future<int> insertSkill(String tableName, Map<String, dynamic> values) async {
    return await (await db).insert(tableName, values);
  }

  Future<List<SkillNode>> getChildrenOf(String tableName, int parentId) async {
    print('!!!!!!!!usao u getchildrenof');
    final List<Map<String, dynamic>> maps = await (await db).query(
      tableName,
      columns: [
        SkillNode.columnId,
        SkillNode.columnParentId,
        SkillNode.columnTitle,
        SkillNode.columnDescription,
        SkillNode.columnIsLeaf,
      ],
      where: '${SkillNode.columnParentId} = ?',
      whereArgs: [parentId],
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
}
