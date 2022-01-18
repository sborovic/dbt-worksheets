import 'package:app/skill_list_tile.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";
import "package:app/models/skill_node_model.dart";

class SkillList extends StatefulWidget {
  final String tableName;
  final List<SkillNode> skillNodes;
  const SkillList({required this.tableName, required this.skillNodes, Key? key})
      : super(key: key);

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
          if (i == widget.skillNodes.length - 1) {
            return Column(children: [
              SkillListTile(description: e.description, index: ++i),
              OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    Text('Add your own idea'),
                  ],
                ),
                onPressed: () async {
                  print('onpress: e.descr = ${e.description}');
                  await SqliteDb().insertSkill(widget.tableName, {
                    SkillNode.columnParentId: e.parentId,
                    SkillNode.columnDescription: 'TEST = $i',
                    SkillNode.columnIsLeaf: 1,
                  });
                  print('after insert');
                  setState(() {});
                },
              ),
            ]);
          }
          return SkillListTile(description: e.description, index: ++i);
        } else {
          return Column(children: [
            ExpansionTile(
              title: Text(e.description),
              children: <Widget>[
                FutureBuilder(
                  future: SqliteDb().getChildrenOf(widget.tableName, e.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SkillNode>> snapshot) {
                    if (snapshot.hasData) {
                      return SkillList(
                        skillNodes: snapshot.data!,
                        tableName: widget.tableName,
                      );
                    }
                    return const Text("Waiting for SkillList...");
                  },
                ),
              ],
            )
          ]);
        }
      }).toList(),
    );
  }
}
