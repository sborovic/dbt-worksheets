import 'package:app/skill_list_tile.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";
import "package:app/models/skill_node_model.dart";
import 'package:flutter/rendering.dart';

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
    print('SkillListRebuilding...');
    return ListView(
      addAutomaticKeepAlives: true,
      primary: false,
      shrinkWrap: true,
      children: widget.skillNodes.mapIndexed((e, i) {
        if (e.isLeaf == true) {
          if (i == widget.skillNodes.length - 1) {
            return Column(key: ValueKey(e.id), children: [
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
          return SkillListTile(
              key: ValueKey(e.id), description: e.description, index: ++i);
        } else {
          return ETW(widget: widget, e: e);
        }
      }).toList(),
    );
  }
}

class ETW extends StatefulWidget {
  const ETW({
    Key? key,
    required this.e,
    required this.widget,
  }) : super(key: key);

  final SkillList widget;
  final SkillNode e;

  @override
  State<ETW> createState() => _ETWState();
}

class _ETWState extends State<ETW> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpansionTile(
      key: ValueKey(widget.e.id),
      title: Text(widget.e.description),
      children: <Widget>[
        FBSL(tableName: widget.widget.tableName, e: widget.e),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
