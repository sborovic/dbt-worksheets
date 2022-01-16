import 'package:app/skill_list_tile.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";
import "package:app/models/skill_node_model.dart";

class SkillList extends StatefulWidget {
  final List<SkillNode> skillNodes;
  const SkillList({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillListState createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: widget.skillNodes.mapIndexed((e, i) {
        if (e.isLeaf == true) {
          print("ovde: ${e.description}");
          return SkillListTile(description: e.description, index: ++i);
        } else {
          return Column(children: [
            ExpansionTile(title: Text(e.description), children: <Widget>[
              SkillList(skillNodes: getChildrenOf(e.id)),
            ])
          ]);
        }
      }).toList(),
    );
  }
}
