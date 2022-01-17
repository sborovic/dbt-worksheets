import 'package:app/db.dart';
import 'package:app/models/skill_node_model.dart';
import 'package:app/worksheet_list_screen.dart';
import 'package:app/skill_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:app/skill_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.mallardGreen),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mallardGreen),
      themeMode: ThemeMode.system,
      home: const WorksheetListScreen(
        moduleName: 'Module: Mindfulness',
        worksheetTableNames: ['mindfulness_worksheet_4a'],
      ),
    );
  }
}
