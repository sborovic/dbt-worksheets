// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../providers/skill_list_provider.dart';
import '../report_factory.dart';

// Project imports:

class ReportOutputScreen extends StatelessWidget {
  static void navigateToReport(BuildContext context) async {
    showDateRangePicker(
      saveText: 'dateRangePickerSave'.tr(),
      useRootNavigator: true,
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (range) async {
        if (range == null) {
          return;
        }
        final reportData = await context
            .read<SkillListProvider>()
            .generateReport(range.start.millisecondsSinceEpoch,
                range.end.millisecondsSinceEpoch + Duration.millisecondsPerDay);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                Provider<DateTimeRange>.value(value: range),
                Provider<List<Map<String, Object?>>>.value(value: reportData),
              ],
              child: const ReportOutputScreen(),
            ),
          ),
        );
      },
    );
  }

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
