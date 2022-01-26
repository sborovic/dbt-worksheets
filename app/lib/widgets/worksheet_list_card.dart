import 'package:app/providers/skill_list_provider.dart';
import 'package:app/screens/report_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/skill_node.dart';
import '../db.dart';

import '../screens/skill_list_screen.dart';

class WorksheetListCard extends StatelessWidget {
  final String title, description;
  final String tableName;

  const WorksheetListCard({
    Key? key,
    required this.tableName,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("wlc build...............");
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.segment_rounded),
            title: Text(
              title,
            ),
            subtitle: Text(description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('IZVEŠTAJ'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SkillListProvider>.value(
                        value: SkillListProvider(
                            tableName: tableName, parentId: 0),
                        child: ReportScreen(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('VEŽBANJE'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SkillListProvider>.value(
                        value: SkillListProvider(
                            tableName: tableName, parentId: 0),
                        child: SkillListScreen(
                          appBarTitle: description,
                        ),
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
