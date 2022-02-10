// Dart imports:
import 'dart:collection';

// Flutter imports:
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:tuple/tuple.dart';

// Project imports:
import '../db.dart';
import '../models/skill_node.dart';

class SkillListProvider with ChangeNotifier {
  final String tableName;
  final int parentId;
  static final HashMap<Tuple2<String, int>, SkillListProvider> _cache =
      HashMap();

  factory SkillListProvider({required tableName, required parentId}) {
    return _cache.putIfAbsent(Tuple2(tableName, parentId),
        () => SkillListProvider._(tableName: tableName, parentId: parentId));
  }
  SkillListProvider._({required this.tableName, required this.parentId}) {
    _update();
  }
  List<SkillNode>? _items;

  Future<void> _update() async {
    _items = await SqliteDb().getChildrenOf(tableName, parentId);
    notifyListeners();
  }

  List<SkillNode>? get items => _items;

  void insertSkill({
    required String title,
    required String description,
  }) async {
    await SqliteDb().insertSkill(
        tableName: tableName,
        title: title,
        description: description,
        parentId: parentId);
    await _update();
  }

  Future<void> deleteSkill({required int id}) async {
    await SqliteDb().deleteSkill(tableName, id);
    return await _update();
  }

  Future<int> logPractice(int id, int datetime) async {
    return await SqliteDb().insertIntoLogs(datetime, tableName, id);
  }

  Future<List<Map<String, Object?>>> generateReport(
      int datetimeFrom, int datetimeTo) async {
    return await SqliteDb().generateReport(tableName, datetimeFrom, datetimeTo);
  }
}
