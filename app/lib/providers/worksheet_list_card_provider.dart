import 'package:app/db.dart';
import 'package:flutter/material.dart';

class WorksheetListCardProvider with ChangeNotifier {
  String tableName;
  String? title, description;
  WorksheetListCardProvider({
    required this.tableName,
  }) {
    _update();
  }
  void _update() async {
    final skillNode = await SqliteDb().getNodeById(tableName, 0);
    title = skillNode.title;
    description = skillNode.description;
    notifyListeners();
  }
}
