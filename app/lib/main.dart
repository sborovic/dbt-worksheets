import 'package:app/db.dart';
import 'package:app/module_menu.dart';
import 'package:app/skills_list.dart';
import 'package:flutter/material.dart';
import 'package:app/constants.dart' as Constants;

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
      home: Scaffold(
        appBar: AppBar(title: const Text('DBT Beležnica')),
        // body: const ModuleMenu(
        //   name: 'Mindfulness veštine',
        //   skillsGroup: Constants.SkillsGroups.mindfulness,
        // ),
        body: SkillsList(
          skillNodes: getChildrenOf(2),
        ),
      ),
    );
  }
}
