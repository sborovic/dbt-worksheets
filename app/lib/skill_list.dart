import 'package:app/skill_list_tile.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";
import "package:app/models/skill_node_model.dart";

class SkillList extends StatefulWidget {
  final Function callback;
  final String tableName;
  final List<SkillNode> skillNodes;
  const SkillList(
      {required this.callback,
      required this.tableName,
      required this.skillNodes,
      Key? key})
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
                  // setState(() {});
                  widget.callback();
                },
              ),
            ]);
          }
          return SkillListTile(description: e.description, index: ++i);
        } else {
          return Column(children: [
            ExpansionTile(
              onExpansionChanged: (val) {
                if (val == true) setState(() {});
              },
              title: Text(e.description),
              children: <Widget>[
                FBSL(tableName: widget.tableName, e: e),
              ],
            )
          ]);
        }
      }).toList(),
    );
  }
}

class FBSL extends StatefulWidget {
  const FBSL({
    Key? key,
    required this.tableName,
    required this.e,
  }) : super(key: key);

  final String tableName;
  final SkillNode e;

  @override
  State<FBSL> createState() => _FBSLState();
}

class _FBSLState extends State<FBSL> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SqliteDb().getChildrenOf(widget.tableName, widget.e.id),
      builder: (BuildContext context, AsyncSnapshot<List<SkillNode>> snapshot) {
        if (snapshot.hasData) {
          return SkillList(
            callback: callback,
            skillNodes: snapshot.data!,
            tableName: widget.tableName,
          );
        }
        return const Text("Waiting for SkillList...");
      },
    );
  }
}
