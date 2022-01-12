import "package:flutter/material.dart";
import "package:app/db.dart";

class SkillsList extends StatefulWidget {
  final List<SkillsNode> skillNodes;
  final ScrollController _scrollController = ScrollController();
  SkillsList({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillsListState createState() => _SkillsListState();
}

class _SkillsListState extends State<SkillsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        primary: false,
        shrinkWrap: true,
        children: ListTile.divideTiles(
          context: context,
          tiles: widget.skillNodes.map((e) {
            if (e.isLeaf == true) {
              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(30, 5, 30, 5), 
       
                title: Text(
                  e.title,
                  
              
                ),
                trailing: const Icon(Icons.check_circle_outline_rounded),
              );
            } else {
              return Column(children: [
                ExpansionTile(
                    title: Text(e.title),
                    //  subtitle: const Text('Trailing expansion arrow icon'),
                    children: <Widget>[
                      SkillsList(skillNodes: getChildrenOf(e.id)),
                    ])
              ]);
            }
          }),
        ).toList());
  }
}
