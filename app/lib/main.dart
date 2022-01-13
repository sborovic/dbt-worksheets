import 'package:app/db.dart';
import 'package:app/module_menu.dart';
import 'package:app/skill_list.dart';
import 'package:flutter/material.dart';
import 'package:app/constants.dart' as Constants;
import 'package:flex_color_scheme/flex_color_scheme.dart';

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
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mallardGreen),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: const Text('DBT Beležnica')),
        // body: const ModuleMenu(
        //   name: 'Mindfulness veštine', 
        //   SkillGroup: Constants.SkillGroups.mindfulness,
        // ),
        body: SkillList(skillNodes: getChildrenOf(2),)
      ),
    );
  }
}
