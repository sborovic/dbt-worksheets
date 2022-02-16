// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/src/public_ext.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
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
    void navigateToSkills() {
      final provider = context.read<SkillListProvider>();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<SkillListProvider>.value(
              value: provider,
              child: SkillListScreen(
                appBarTitle: description,
              ),
            );
          },
        ),
      );
    }

    return InkWell(
      onTap: navigateToSkills,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // contentPadding: EdgeInsets.only(top: 8),
              leading: const Icon(Icons.self_improvement),
              title: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  title,
                ),
              ),
              subtitle: Text(description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('buttonReport').tr(),
                  onPressed: () => ReportOutputScreen.navigateToReport(context),
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('buttonSkills').tr(),
                  onPressed: navigateToSkills,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
