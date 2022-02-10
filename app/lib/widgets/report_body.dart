// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Project imports:

class ReportBody extends StatelessWidget {
  final statisticsTextStyle =
      TextStyle(fontFamily: GoogleFonts.courgette().fontFamily, fontSize: 20);

  ReportBody({Key? key}) : super(key: key);

  Text _buildNonLeafEntry(BuildContext context, String description, int level) {
    late final TextStyle ts;
    switch (level) {
      case 0:
        ts = Theme.of(context).textTheme.headline5!;
        break;
      case 1:
        ts = Theme.of(context).textTheme.headline6!;
        break;
      default:
        ts = Theme.of(context).textTheme.subtitle1!;
    }
    return Text(description, style: ts);
  }

  Row _buildLeafEntry(int count, String description) {
    return Row(children: [
      Expanded(
        flex: 85,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(description),
        ),
      ),
      Expanded(
        flex: 15,
        child: Center(
          child: Text(
            count.toString(),
            style: statisticsTextStyle,
          ),
        ),
      ),
    ]);
  }

  Widget _buildEntry(BuildContext context, Map<String, Object?> map) {
    if (map['is_leaf'] == 1) {
      return _buildLeafEntry(map['count'] as int, map['description'] as String);
    } else {
      return _buildNonLeafEntry(
          context, map['description'] as String, map['level'] as int);
    }
  }

  Widget _buildHeaderRow(BuildContext context, String label, String content) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            label + ' ',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            child: Text(
              content,
              style: statisticsTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  String _parseDate(BuildContext context, DateTime date) {
    return DateFormat.yMMMMd(context.locale.toString()).format(date);
  }

  Widget buildHeader(BuildContext context, DateTime from, DateTime to) {
    return Column(
      children: [
        _buildHeaderRow(context, 'Datum početka:', _parseDate(context, from)),
        _buildHeaderRow(context, 'Datum kraja:', _parseDate(context, to)),
      ],
    );
  }

  ListView _buildReportList(
      BuildContext context, List<Map<String, Object?>> data) {
    final range = context.read<DateTimeRange>();
    return ListView(
      children: [
        buildHeader(context, range.start, range.end),
        if (data.isNotEmpty)
          ...data.map((map) {
            return _buildEntry(context, map);
          }).toList()
        else
          const Center(
            child: Text('Nema zabeleženih vežbanja'),
          )
      ]
          .map((widget) =>
              Padding(padding: const EdgeInsets.all(10), child: widget))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reportData = context.read<List<Map<String, Object?>>>();
    return _buildReportList(context, reportData);
  }
}
