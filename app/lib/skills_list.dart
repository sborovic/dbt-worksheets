import 'package:app/skill_tile.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";

class SkillsList extends StatefulWidget {
  final List<SkillsNode> skillNodes;
  const SkillsList({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillsListState createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        primary: false,
        shrinkWrap: true,
        children: widget.skillNodes.mapIndexed((e, i) {
          if (e.isLeaf == true) {
            return SkillTile(description: e.title, index: ++i);
          } else {
            return Column(children: [
              ExpansionTile(title: Text(e.title),
                  children: <Widget>[
                    SkillsList(skillNodes: getChildrenOf(e.id)),
                  ])
            ]);
          }
        }).toList());
  }
}
