import 'package:app/db.dart';
import "package:flutter/material.dart";
import 'package:app/skill_list_screen.dart';

import 'models/skill_node_model.dart';

class WorksheetListCard extends StatelessWidget {
  final SkillNode skillNode;
  final String tableName;

  const WorksheetListCard(
      {Key? key, required this.skillNode, required this.tableName})
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
                      builder: (context) => FutureBuilder(
                          future:
                              SqliteDb().getChildrenOf(tableName, skillNode.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<SkillNode>> snapshot) {
                            if (snapshot.hasData) {
                              return SkillListScreen(
                                appBarTitle: skillNode.title,
                                skillNodes: snapshot.data!,
                                tableName: tableName,
                              );
                            } else {
                              return const Text('Waiting for SkillListScreen');
                            }
                          }),
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
