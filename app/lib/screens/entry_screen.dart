// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../widgets/worksheet_list.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DBT: Radni listovi').tr(),
      ),
      body: ListView(
        children: [
          WorksheetList(
            moduleName: 'Mindfulness'.tr(),
            worksheetTableNames: const [
              'mindfulness_worksheet_4a',
            ],
          ),
        ],
      ),
    );
  }
}
