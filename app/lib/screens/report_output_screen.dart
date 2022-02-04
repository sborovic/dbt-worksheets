import 'package:app/widgets/report_body.dart';
import 'package:flutter/material.dart';

class ReportOutputScreen extends StatelessWidget {
  const ReportOutputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Izveštaj'),
      ),
      body: ReportBody(),
    );
  }
}
