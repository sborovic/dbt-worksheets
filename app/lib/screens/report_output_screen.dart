// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/widgets/report_body.dart';

import '../report_helper_methods.dart';

class ReportOutputScreen extends StatelessWidget {
  const ReportOutputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBarReport').tr(),
        actions: [
          IconButton(
            onPressed: () {
              generatePdf();
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: ReportBody(),
    );
  }
}
