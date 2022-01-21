import 'package:app/providers/skill_list_provider.dart';

import 'package:app/widgets/expansion_tile_wrapper.dart';
import 'package:app/widgets/skill_list_tile.dart';
import 'package:app/widgets/skill_list_tile_editable.dart';
import "package:flutter/material.dart";

import "package:app/extensions.dart";
import 'package:app/models/skill_node.dart';

import 'package:provider/provider.dart';

class SkillList extends StatefulWidget {
  final List<SkillNode>? skillNodes;
  const SkillList({required this.skillNodes, Key? key}) : super(key: key);

  @override
  _SkillListState createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  bool _showButton = true;

  void showButton() {
    setState(() {
      _showButton = true;
    });
  }

  void hideButton() {
    setState(() {
      _showButton = false;
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
                  return Column(
                    children: [
                      SkillListTile(description: e.description, index: ++i),
                      _showButton
                          ? OutlinedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add),
                                  Text('Add your own idea'),
                                ],
                              ),
                              onPressed: () {
                                hideButton();
                              },
                            )
                          : SkillListTileEditable(
                              index: i + 1, showButton: showButton),
                    ],
                  );
                }
                return SkillListTile(description: e.description, index: ++i);
              } else {
                return ChangeNotifierProvider<SkillListProvider>.value(
                  value: SkillListProvider(
                      tableName: context.read<SkillListProvider>().tableName,
                      parentId: e.id),
                  child: ExpansionTileWrapper(title: e.description),
                );
              }
            }).toList(),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
