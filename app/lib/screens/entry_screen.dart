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
        title: const Text('appName').tr(),
      ),
      body: ListView(
        children: [
          WorksheetList(
            moduleName: 'moduleMindfulness'.tr(),
            worksheetTableNames: const [
              'mindfulness_worksheet_4a',
            ],
          ),
        ],
      ),
    );
  }
}
