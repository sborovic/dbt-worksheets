import 'package:app/skill_list_tile.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";

class SkillListScreen extends StatefulWidget {
  final List<SkillNode> skillNodes;
  const SkillListScreen({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillListScreenState createState() => _SkillListScreenState();
}

class _SkillListScreenState extends State<SkillListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ovde')),
      body: ListView(
          primary: false,
          shrinkWrap: true,
          children: widget.skillNodes.mapIndexed((e, i) {
            if (e.isLeaf == true) {
              print("ovde: ${e.description}");
              return SkillListTile(description: e.description, index: ++i);
            } else {
              return Column(children: [
                ExpansionTile(title: Text(e.description), children: <Widget>[
                  SkillListScreen(skillNodes: getChildrenOf(e.id)),
                ])
              ]);
            }
          }).toList()),
    );
  }
}
