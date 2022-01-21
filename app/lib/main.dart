import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'screens/worksheet_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
