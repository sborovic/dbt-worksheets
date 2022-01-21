import 'package:app/providers/worksheet_list_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../db.dart';
import '../models/skill_node.dart';

import '../widgets/worksheet_list_card.dart';

class WorksheetListScreen extends StatefulWidget {
  final String moduleName;
  final List<String> worksheetTableNames;

  const WorksheetListScreen({
    required this.moduleName,
    required this.worksheetTableNames,
    Key? key,
  }) : super(key: key);

  @override
  State<WorksheetListScreen> createState() => _WorksheetListScreenState();
}

class _WorksheetListScreenState extends State<WorksheetListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DBT: Worksheets'),
      ),
      body: ListView(
        children: [
          Container(
            child: Text(
              widget.moduleName,
              style: const TextStyle(fontSize: 28),
            ),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          ...widget.worksheetTableNames
              .map(
                (e) => ChangeNotifierProvider<WorksheetListCardProvider>(
                    create: (_) => WorksheetListCardProvider(tableName: e),
                    builder: (context, _) {
                      return WorksheetListCard(
                        tableName: e,
                        title: Provider.of<WorksheetListCardProvider>(context)
                                .title ??
                            '',
                        description:
                            Provider.of<WorksheetListCardProvider>(context)
                                    .description ??
                                '',
                      );
                    }),
              )
              .toList(),
        ],
      ),
    );
  }
}
