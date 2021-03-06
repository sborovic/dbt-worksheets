// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
import '../db.dart';
import '../models/skill_node.dart';
import 'worksheet_list_card.dart';

class WorksheetList extends StatefulWidget {
  final String moduleName;
  final List<String> worksheetTableNames;

  const WorksheetList({
    required this.moduleName,
    required this.worksheetTableNames,
    Key? key,
  }) : super(key: key);

  @override
  State<WorksheetList> createState() => _WorksheetListState();
}

class _WorksheetListState extends State<WorksheetList> {
  late final Map<String, Future<SkillNode>> futures;
  @override
  void initState() {
    super.initState();
    futures = {
      for (var tableName in widget.worksheetTableNames)
        tableName: SqliteDb().getNodeById(tableName, 0)
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: [
        Container(
          child: Text(
            widget.moduleName,
            style: Theme.of(context).textTheme.headline5,
          ),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        ...widget.worksheetTableNames
            .map(
              (tableName) => FutureBuilder<SkillNode>(
                future: futures[tableName],
                builder: (context, AsyncSnapshot<SkillNode> snapshot) {
                  if (snapshot.hasData) {
                    return ChangeNotifierProvider<SkillListProvider>.value(
                      value:
                          SkillListProvider(tableName: tableName, parentId: 0),
                      child: WorksheetListCard(
                        tableName: tableName,
                        title: snapshot.data!.title,
                        description: snapshot.data!.description,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
            .toList(),
      ],
    );
  }
}
