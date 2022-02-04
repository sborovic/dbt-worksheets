import 'package:flutter/material.dart';

import 'worksheet_list.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DBT: Radni listovi'),
      ),
      body: ListView(
        children: const [
          WorksheetList(
            moduleName: 'Mindfulness',
            worksheetTableNames: [
              'mindfulness_worksheet_4a',
            ],
          ),
        ],
      ),
    );
  }
}
