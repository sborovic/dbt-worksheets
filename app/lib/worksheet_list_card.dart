import 'package:app/db.dart';
import "package:flutter/material.dart";
import 'package:app/skill_list_screen.dart';

class WorksheetListCard extends StatelessWidget {
  final String title, subtitle;
  final int id;

  const WorksheetListCard(
      {Key? key, required this.title, required this.subtitle, required this.id})
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
              title,
            ),
            subtitle: Text(subtitle),
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
                        skillNodes: getChildrenOf(2),
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
