// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Project imports:

import 'package:provider/provider.dart';

import '../providers/skill_list_provider.dart';
import '../report_factory.dart';

class ReportOutputScreen extends StatelessWidget {
  const ReportOutputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appBarReport').tr(),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint(Theme.of(context).textTheme.bodyMedium?.fontFamily);
              generatePdf(context);
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: ListView(
        children:
            ReportBuilder(type: ReportType.materialReport, context: context)
                .build()
                .cast<Widget>(),
      ),
    );
  }
}
