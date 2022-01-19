import 'package:app/skill_list.dart';
import 'package:flutter/material.dart';

import 'package:app/models/skill_node_model.dart';

class SkillListScreen extends StatefulWidget {
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
  State<SkillListScreen> createState() => _SkillListScreenState();
}

class _SkillListScreenState extends State<SkillListScreen> {
  void SLSCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.appBarTitle)),
      body: SkillList(
        callback: SLSCallback,
        key: UniqueKey(),
        skillNodes: widget.skillNodes,
        tableName: widget.tableName,
      ),
    );
  }
}
