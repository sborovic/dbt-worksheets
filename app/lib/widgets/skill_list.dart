// Flutter imports:
import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import "package:app/extensions.dart";
import 'package:app/models/skill_node.dart';
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/expansion_tile_wrapper.dart';
import 'package:app/widgets/skill_list_tile.dart';
import 'package:app/widgets/skill_list_tile_editable.dart';

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
            children: [
              if (widget.skillNodes!.isNotEmpty)
                ...widget.skillNodes!.mapIndexed((e, i) {
                  if (e.isLeaf == true) {
                    return SkillListTile(
                        id: e.id, description: e.description, index: ++i);
                  } else {
                    return ChangeNotifierProvider<SkillListProvider>.value(
                      value: SkillListProvider(
                          tableName:
                              context.read<SkillListProvider>().tableName,
                          parentId: e.id),
                      child: ExpansionTileWrapper(title: e.description),
                    );
                  }
                }).toList(),
              if (widget.skillNodes!.isEmpty ||
                  widget.skillNodes!.first.isLeaf == true)
                _showButton
                    ? OutlinedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add),
                            Text('Dodaj svoju ideju'),
                          ],
                        ),
                        onPressed: () {
                          hideButton();
                        },
                      )
                    : SkillListTileEditable(
                        index: widget.skillNodes!.isNotEmpty
                            ? widget.skillNodes!.length + 1
                            : 1,
                        showButton: showButton),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
