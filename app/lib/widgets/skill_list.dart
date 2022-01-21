import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list_tile.dart';
import 'package:app/widgets/skill_list_tile_editable.dart';
import "package:flutter/material.dart";
import "package:app/db.dart";
import "package:app/extensions.dart";
import 'package:app/models/skill_node.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SkillList extends StatefulWidget {
  final List<SkillNode>? skillNodes;
  const SkillList({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillListState createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  bool showButton = true;
  void setStateCallback() {
    setState(() {});
  }

  void hideButton() {
    setState(() {
      showButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.skillNodes != null
        ? ListView(
            addAutomaticKeepAlives: true,
            primary: false,
            shrinkWrap: true,
            children: widget.skillNodes!.mapIndexed((e, i) {
              if (e.isLeaf == true) {
                if (i == widget.skillNodes!.length - 1) {
                  return showButton
                      ? Column(children: [
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
                              // await SqliteDb().insertSkill(widget.tableName, {
                              //   SkillNode.columnParentId: e.parentId,
                              //   SkillNode.columnDescription: 'TEST = $i',
                              //   SkillNode.columnIsLeaf: 1,
                              // });
                              // widget.callback();
                              setState(() {
                                showButton = false;
                              });
                            },
                          ),
                        ])
                      : SkillListTileEditable(
                          index: i + 1, hideButton: hideButton);
                }
                return SkillListTile(description: e.description, index: ++i);
              } else {
                return ChangeNotifierProvider<SkillListProvider>(
                  create: (_) => SkillListProvider(
                      tableName:
                          Provider.of<SkillListProvider>(context, listen: false)
                              .tableName,
                      parentId: e.id),
                  child: ExpansionTileWrapper(title: e.description),
                );
              }
            }).toList(),
          )
        : const CircularProgressIndicator();
  }
}

class ExpansionTileWrapper extends StatefulWidget {
  const ExpansionTileWrapper({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<ExpansionTileWrapper> createState() => _ExpansionTileWrapperState();
}

class _ExpansionTileWrapperState extends State<ExpansionTileWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpansionTile(
      title: Text(widget.title),
      children: <Widget>[
        Consumer<SkillListProvider>(builder: (_, provider, __) {
          return SkillList(
            skillNodes: provider.items,
          );
        })
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
