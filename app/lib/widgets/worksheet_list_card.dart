// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/src/public_ext.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/screens/report_input_screen.dart';
import 'package:app/screens/report_output_screen.dart';
import '../db.dart';
import '../models/skill_node.dart';
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
                child: const Text('IZVEŠTAJ').tr(),
                onPressed: () async {
                  showDateRangePicker(
                    useRootNavigator: true,
                    context: context,
                    firstDate: DateTime(2021),
                    lastDate: DateTime.now(),
                  ).then((range) async {
                    if (range == null) {
                      return;
                    }
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SkillListProvider>.value(
                        value: SkillListProvider(
                            tableName: tableName, parentId: 0),
                        child: ReportOutputScreen(range),
                      ),
                    ));
                  });
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('VEŽBANJE').tr(),
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
