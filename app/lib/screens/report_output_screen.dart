// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/widgets/report_body.dart';

class ReportOutputScreen extends StatelessWidget {
  final DateTimeRange range;
  const ReportOutputScreen(this.range, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Izveštaj'),
      ),
      body: ReportBody(from: range.start, to: range.end),
    );
  }
}
