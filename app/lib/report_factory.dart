import 'dart:io';

import 'package:app/providers/skill_list_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' as m;
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

final pdf = pw.Document();
// void generatePdf(List<Map<String, Object?>> reportData) async {
//   pdf.addPage(Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (_) {
//         return pw.Center(
//           child: Bullet(),
//         ); // Center
//       }));
//   var status = await Permission.storage.status;

//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }

//   final file = await File("/storage/emulated/0/Download/TEST.pdf");

//   await file.writeAsBytes(await pdf.save());
//   Share.shareFiles(["/storage/emulated/0/Download/TEST.pdf"],
//       mimeTypes: ['application/pdf'],
//       subject: 'Ovo je subject',
//       text: 'Ovo je tekst');

// final directory =
//     (await getExternalStorageDirectories(type: StorageDirectory.downloads))!
//         .first;
// debugPrint("OVDE SAMMMMMMMMMM" + directory.toString());
// File file2 = File("${directory.path}/test.txt");
// await file2.writeAsString('TEST ONE');
// }

abstract class AbstractReportFactory {
  m.BuildContext context;
  AbstractReportFactory(this.context);
  dynamic get textStyleHeadline5;
  dynamic get textStyleHeadline6;
  dynamic get textStyleSubtitle1;
  dynamic get statisticsTextStyle;
  dynamic createText(String data, {style});
  dynamic createRow({required List<dynamic> children});
  dynamic createExpanded({int flex = 1, required child});
  dynamic createPadding({required padding, required child});
  dynamic createEdgeInsetsSymmetric(
      {required double horizontal, required double vertical});
  dynamic createEdgeInsetsAll(double all);
  dynamic createCenter({required child});
  dynamic createColumn({required List<dynamic> children});
  dynamic createListView({required List<dynamic> children});
  String _parseDate(DateTime date) {
    return DateFormat.yMMMMd(context.locale.toString()).format(date);
  }
}

// class PdfReportFactory extends AbstractReportFactory {
//   PdfReportFactory(m.BuildContext context) : super(context);

//   @override
//   dynamic createText(String data, {style}) {
//     return pw.Text(data, style: style);
//   }

//   @override
//   dynamic get textStyleHeadline5 => pw.Theme.of(context).textTheme.headline5!;

//   @override
//   dynamic get textStyleHeadline6 => pw.Theme.of(context).textTheme.headline6!;

//   @override
//   dynamic get textStyleSubtitle1 => pw.Theme.of(context).textTheme.subtitle1!;

//   @override
//   dynamic createRow({required List<dynamic> children}) {
//     return pw.Row(children: children.cast<m.Widget>());
//   }

//   @override
//   createExpanded({int flex = 1, required child}) {
//     return pw.Expanded(flex: flex, child: child);
//   }

//   @override
//   dynamic createEdgeInsetsSymmetric(
//       {required double horizontal, required double vertical}) {
//     return pw.EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
//   }

//   @override
//   dynamic createPadding({required padding, required child}) {
//     return pw.Padding(padding: padding, child: child);
//   }

//   @override
//   dynamic createCenter({required child}) {
//     return pw.Center(child: child);
//   }

//   @override
//   get statisticsTextStyle => pw.TextStyle(
//       fontFamily: GoogleFonts.courgette().fontFamily, fontSize: 20);

//   @override
//   dynamic createEdgeInsetsAll(double all) {
//     return pw.EdgeInsets.all(all);
//   }

//   @override
//   dynamic createColumn({required List<dynamic> children}) {
//     return pw.Column(children: children.cast<pw.Widget>());
//   }

//   @override
//   dynamic createListView({required List children}) {
//     return pw.ListView(children: children.cast<pw.Widget>());
//   }
// }

class MaterialReportFactory extends AbstractReportFactory {
  MaterialReportFactory(m.BuildContext context) : super(context);

  @override
  dynamic createText(String data, {style}) {
    return m.Text(data, style: style);
  }

  @override
  dynamic get textStyleHeadline5 => m.Theme.of(context).textTheme.headline5!;

  @override
  dynamic get textStyleHeadline6 => m.Theme.of(context).textTheme.headline6!;

  @override
  dynamic get textStyleSubtitle1 => m.Theme.of(context).textTheme.subtitle1!;

  @override
  dynamic createRow({required List<dynamic> children}) {
    return m.Row(children: children.cast<m.Widget>());
  }

  @override
  createExpanded({int flex = 1, required child}) {
    return m.Expanded(flex: flex, child: child);
  }

  @override
  dynamic createEdgeInsetsSymmetric(
      {required double horizontal, required double vertical}) {
    return m.EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  @override
  dynamic createPadding({required padding, required child}) {
    return m.Padding(padding: padding, child: child);
  }

  @override
  dynamic createCenter({required child}) {
    return m.Center(child: child);
  }

  @override
  get statisticsTextStyle =>
      m.TextStyle(fontFamily: GoogleFonts.courgette().fontFamily, fontSize: 20);

  @override
  dynamic createEdgeInsetsAll(double all) {
    return m.EdgeInsets.all(all);
  }

  @override
  dynamic createColumn({required List<dynamic> children}) {
    return m.Column(children: children.cast<m.Widget>());
  }

  @override
  dynamic createListView({required List children}) {
    return m.ListView(children: children.cast<m.Widget>());
  }
}

enum ReportType { materialReport, pdfReport }

class ReportBuilder {
  final AbstractReportFactory f;
  ReportBuilder({required ReportType type, required m.BuildContext context})
      : f = (type == ReportType.materialReport)
            ? MaterialReportFactory(context)
            : MaterialReportFactory(context);

  dynamic _buildNonLeafEntry(String description, int level) {
    late final dynamic ts;
    switch (level) {
      case 0:
        ts = f.textStyleHeadline5;
        break;
      case 1:
        ts = f.textStyleHeadline6;
        break;
      default:
        ts = f.textStyleSubtitle1;
    }
    return f.createText(description, style: ts);
  }

  dynamic _buildLeafEntry(int count, String description) {
    return f.createRow(children: [
      f.createExpanded(
        flex: 85,
        child: f.createPadding(
          padding: f.createEdgeInsetsSymmetric(horizontal: 10, vertical: 5),
          child: f.createText(description),
        ),
      ),
      f.createExpanded(
        flex: 15,
        child: f.createCenter(
          child: f.createText(
            count.toString(),
            style: f.statisticsTextStyle,
          ),
        ),
      ),
    ]);
  }

  dynamic _buildEntry(Map<String, Object?> map) {
    if (map['is_leaf'] == 1) {
      return _buildLeafEntry(map['count'] as int, map['description'] as String);
    } else {
      return _buildNonLeafEntry(
          map['description'] as String, map['level'] as int);
    }
  }

  dynamic _buildHeaderRow(String label, String content) {
    return f.createPadding(
      padding: f.createEdgeInsetsAll(5),
      child: f.createRow(
        children: [
          f.createText(
            label + ' ',
            style: f.textStyleSubtitle1,
          ),
          f.createExpanded(
            child: f.createText(
              content,
              style: f.statisticsTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  dynamic _buildHeader(DateTime from, DateTime to) {
    return f.createColumn(
      children: [
        _buildHeaderRow('Datum početka:', f._parseDate(from)),
        _buildHeaderRow('Datum kraja:', f._parseDate(to)),
      ],
    );
  }

  dynamic build() {
    final reportData = f.context.read<List<Map<String, Object?>>>();
    final range = f.context.read<m.DateTimeRange>();
    return f.createListView(
      children: [
        _buildHeader(range.start, range.end),
        if (reportData.isNotEmpty)
          ...reportData.map((map) {
            return _buildEntry(map);
          }).toList()
        else
          f.createCenter(
            child: f.createText('Nema zabeleženih vežbanja'),
          )
      ]
          .map((widget) => f.createPadding(
              padding: f.createEdgeInsetsAll(10), child: widget))
          .toList(),
    );
  }
}
