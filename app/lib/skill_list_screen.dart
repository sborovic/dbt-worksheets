import 'package:app/skill_list.dart';
import 'package:flutter/material.dart';

import 'package:app/models/skill_node_model.dart';

class SkillListScreen extends StatelessWidget {
  final List<SkillNode> skillNodes;
  final String tableName;
  final String appBarTitle;
  const SkillListScreen({
    required this.tableName,
    required this.appBarTitle,
    required this.skillNodes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: SkillList(
        key: UniqueKey(),
        skillNodes: skillNodes,
        tableName: tableName,
      ),
    );
  }
}
