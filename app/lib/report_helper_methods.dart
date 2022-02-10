import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

final pdf = pw.Document();
void generatePdf() async {
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Bullet(),
        ); // Center
      }));
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  }

  final file = await File("/storage/emulated/0/Download/TEST.pdf");

  await file.writeAsBytes(await pdf.save());
  Share.shareFiles(["/storage/emulated/0/Download/TEST.pdf"],
      mimeTypes: ['application/pdf'],
      subject: 'Ovo je subject',
      text: 'Ovo je tekst');

  // final directory =
  //     (await getExternalStorageDirectories(type: StorageDirectory.downloads))!
  //         .first;
  // debugPrint("OVDE SAMMMMMMMMMM" + directory.toString());
  // File file2 = File("${directory.path}/test.txt");
  // await file2.writeAsString('TEST ONE');
}
