import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../models/skill_node.dart';
import '../db.dart';

class SkillListProvider with ChangeNotifier {
  String tableName;
  int parentId;
  SkillListProvider({required this.tableName, required this.parentId}) {
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
    await SqliteDb().insertSkill(tableName, {
      SkillNode.columnTitle: title,
      SkillNode.columnDescription: description,
      SkillNode.columnParentId: parentId,
    });
    await _update();
  }
}
