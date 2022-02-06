// Flutter imports:

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list_tile_body.dart';

class ReportBody extends StatelessWidget {
  final DateTime from;
  final DateTime to;
  final ts =
      TextStyle(fontFamily: GoogleFonts.courgette().fontFamily, fontSize: 20);

  final name = 'Kozica Vođičić';
  ReportBody({required this.from, required this.to, Key? key})
      : super(key: key);

  Text buildNonLeafEntry(BuildContext context, String description, int level) {
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

  Row buildLeafEntry(int count, String description) {
    return Row(children: [
      Expanded(
        flex: 85,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(description),
        ),
      ),
      Expanded(
        flex: 15,
        child: Center(
          child: Text(
            count.toString(),
            style: ts,
          ),
        ),
      ),
    ]);
  }

  Widget buildEntry(BuildContext context, Map<String, Object?> map) {
    if (map['is_leaf'] == 1) {
      return buildLeafEntry(map['count'] as int, map['description'] as String);
    } else {
      return buildNonLeafEntry(
          context, map['description'] as String, map['level'] as int);
    }
  }

  Widget buildHeaderRow(BuildContext context, String label, String content) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            label + ' ',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Expanded(
            child: Text(
              content,
              // textAlign: TextAlign.right,
              style: ts,
            ),
          ),
        ],
      ),
    );
  }

  String _parseDate(BuildContext context, DateTime date) {
    return DateFormat.yMMMMd(context.locale.toString()).format(date);
  }

  Widget buildHeader(
      BuildContext context, String name, DateTime from, DateTime to) {
    return Column(
      children: [
        buildHeaderRow(context, 'Ime:', name),
        buildHeaderRow(context, 'Datum početka:', _parseDate(context, from)),
        buildHeaderRow(context, 'Datum kraja:', _parseDate(context, to)),
      ],
    );
  }

  ListView buildReportList(
      BuildContext context, List<Map<String, Object?>> data) {
    return ListView(
      children: [
        buildHeader(context, name, from, to),
        if (data.isNotEmpty)
          ...data.map((map) {
            return buildEntry(context, map);
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
    return FutureBuilder(
      future: context.read<SkillListProvider>().generateReport(
          from.millisecondsSinceEpoch,
          to.millisecondsSinceEpoch + Duration.millisecondsPerDay),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data!.toString());
          return buildReportList(context, snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
