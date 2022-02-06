// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:app/widgets/report_body.dart';
import 'package:app/widgets/skill_list_tile.dart';

class ReportInputScreen extends StatefulWidget {
  ReportInputScreen({Key? key}) : super(key: key);

  @override
  State<ReportInputScreen> createState() => _ReportInputScreenState();
}

class _ReportInputScreenState extends State<ReportInputScreen> {
  int _index = 0;
  DateTime? from;
  DateTime? to;
  void _showDateFrom(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(2021),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Izveštaj'),
        ),
        body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            InputDatePickerFormField(
              fieldLabelText: 'Datum pocetka',
              firstDate: DateTime(2018),
              lastDate: DateTime(2050),
            ),
            ListTile(
              title: Text('Datum pocetka:'),
            )
          ],
        ));
  }
}
