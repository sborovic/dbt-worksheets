import 'dart:io';

import "package:app/models/skill_node_model.dart";
import 'package:flutter/services.dart';

import "dart:io" as io;
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
    _db = await initDb();
    return _db!;
  }

  /// Initialize DB
  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "app.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db_en.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    return await openDatabase(path, readOnly: true);
  }

  /// Count number of tables in DB
  Future<int> countTable() async {
    var dbClient = await db;
    var res =
        await dbClient.rawQuery("""SELECT count(*) as count FROM mindfulness
        """);
    return res[0]['count'] as int;
  }
}

List<SkillNode> getChildrenOf(int parentId) {
  if (parentId == 1) {
    return [
      SkillNode(
          description: 'materijal', title: 'Posmatranje', id: 2, isLeaf: false)
    ];
  }
  if (parentId == 2) {
    return [
      SkillNode(
          id: 10,
          description: "Posmatranje očima",
          title: 'titl',
          isLeaf: false),
      SkillNode(
          id: 20,
          title: "titl",
          description: "Posmatranje zvukova",
          isLeaf: false),
    ];
  }
  if (parentId == 10) {
    return [
      SkillNode(
          id: 11,
          description: "Lezite na zemlju/travu i posmatrajte oblake na nebu",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 12,
          description:
              "Write out a nonjudgmental blow-by-blow account of a particularly important episode in your day.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 13,
          description:
              "Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 14,
          description: "Lezite na zemlju/travu i posmatrajte oblake na nebu",
          title: 'titl',
          isLeaf: false),
      SkillNode(
          id: 15,
          description:
              "Hodajte sporije, zaustavite se negde gde imate pogled, posmatrajte cveće, drveće i prirodu.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 16,
          description:
              "Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          title: 'titl',
          isLeaf: true),
    ];
  }
  if (parentId == 14) {
    return [
      SkillNode(
          id: 17,
          description:
              "UNUTAR> Hodajte sporije, zaustavite se negde gde imate pogled, posmatrajte cveće, drveće i prirodu.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 18,
          description:
              "UNUTAR> Sedite napolju. Posmatrajte ko i šta prolazi ispred vas, bez da pokretima glave ili pogledom pratite njihovo kretanje.",
          title: 'titl',
          isLeaf: true),
    ];
  }
  if (parentId == 20) {
    return [
      SkillNode(
          id: 21,
          description:
              "Zaustavite se na momenat i osluškujte. Slušajte teksturu i oblik zvukova oko vas. Pokušajte da čujete tišinu između zvukova.",
          title: 'titl',
          isLeaf: true),
      SkillNode(
          id: 12,
          description:
              "Dok neko priča, slušajte visinu glasa, mekoću ili grubost zvukova, jasnoću i razgovetnost govora, pauze između pojedinih reči.",
          title: 'titl',
          isLeaf: true),
    ];
  }
  return [];
}
