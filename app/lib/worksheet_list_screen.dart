import 'package:app/db.dart';
import 'package:app/worksheet_list_card.dart';
import 'package:flutter/material.dart';

class WorksheetListScreen extends StatelessWidget {
  final List<SkillNode> skillNodes;
  final String moduleName;
  const WorksheetListScreen({required this.moduleName, required this.skillNodes, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DBT: Radni listovi'),
      ),
      body: ListView(children: [
      Container(
        child: Text(
          moduleName,
          style: const TextStyle(fontSize: 28),
        ),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
      ),
      ...skillNodes
          .map((e) => WorksheetListCard(
                title: e.title,
                subtitle: e.description,
              ))
          .toList(),
    ])
      
    );
  }
}