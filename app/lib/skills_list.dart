import "package:flutter/material.dart";
import "package:app/db.dart";

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
      shrinkWrap: true,
      children: widget.skillNodes.map((e) {
        if (e.isLeaf == true) {
          return ListTile(
            title: Text(e.title),
          );
        } else {
          return Column(children: [
            ExpansionTile(
                title: Text(e.title),
                subtitle: const Text('Trailing expansion arrow icon'),
                children: <Widget>[
                  SkillsList(skillNodes: getChildrenOf(e.id)),
                ])
          ]);
        }
      }).toList(),
    );
  }
}
