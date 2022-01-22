import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:tuple/tuple.dart';
import '../models/skill_node.dart';
import '../db.dart';

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
    debugPrint('!!!!!!!!!!!!!!!SkillListProvider CONSTRUCTOR obican!!!');
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

  Future<void> deleteSkill({required int id}) async {
    await SqliteDb().deleteSkill(tableName, id);
    return await _update();
  }
}
