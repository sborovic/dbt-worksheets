// Flutter imports:
import 'package:app/screens/skill_list_screen.dart';
import "package:flutter/material.dart";

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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

  @override
  Widget build(BuildContext context) {
    void showButton() {
      context.read<ShowFabProvider>().visible = true;
      setState(() {
        _showButton = true;
      });
    }

    void hideButton() {
      context.read<ShowFabProvider>().visible = false;
      setState(() {
        _showButton = false;
      });
    }

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
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: OutlinedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add),
                              const Text('buttonAddYourIdea').tr(),
                            ],
                          ),
                          onPressed: () {
                            hideButton();
                          },
                        ),
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
