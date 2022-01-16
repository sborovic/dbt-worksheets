import 'package:app/db.dart';
import "package:flutter/material.dart";
import 'package:app/skill_list_screen.dart';

import 'models/skill_node_model.dart';

class WorksheetListCard extends StatelessWidget {
  final SkillNode skillNode;

  const WorksheetListCard({Key? key, required this.skillNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.segment_rounded),
            title: Text(
              skillNode.title,
            ),
            subtitle: Text(skillNode.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('IZVEŠTAJ'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('VEŽBANJE'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SkillListScreen(
                        appBarTitle: skillNode.title,
                        skillNodes: getChildrenOf(skillNode.id),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
