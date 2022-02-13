// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../providers/theme_provider.dart';
import '../widgets/worksheet_list.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('appName').tr(), actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            context.read<ThemeProvider>().toggleMode();
          },
        )
      ]),
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
