import 'package:app/db.dart';
import 'package:app/worksheet_list_card.dart';
import 'package:flutter/material.dart';

import 'models/skill_node_model.dart';

class WorksheetListScreen extends StatelessWidget {
  final List<String> worksheetTableNames;
  final String moduleName;
  const WorksheetListScreen({
    required this.moduleName,
    required this.worksheetTableNames,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(moduleName),
      ),
      body: ListView(
        children: [
          Container(
            child: Text(
              moduleName,
              style: const TextStyle(fontSize: 28),
            ),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          ...worksheetTableNames
              .map(
                (e) => FutureBuilder(
                  future: SqliteDb().getNodeById(e, 0),
                  builder: (BuildContext context,
                      AsyncSnapshot<SkillNode> snapshot) {
                    if (snapshot.hasData) {
                      return WorksheetListCard(
                        tableName: e,
                        skillNode: snapshot.data!,
                      );
                    }
                    return const Text('Waiting for WorksheetListCard...');
                  },
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
