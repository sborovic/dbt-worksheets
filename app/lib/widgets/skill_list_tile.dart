import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/popup_menu_container.dart';
import 'package:app/widgets/skill_list_tile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/src/provider.dart';

enum MenuOptions { delete }

class SkillListTile extends StatefulWidget {
  final String description;
  final int id;
  final int index;

  const SkillListTile(
      {required this.description,
      required this.index,
      required this.id,
      Key? key})
      : super(key: key);

  @override
  State<SkillListTile> createState() => _SkillListTileState();
}

class _SkillListTileState extends State<SkillListTile> {
  bool _showDelete = false;
  bool get showDelete => _showDelete;
  set showDelete(bool value) {
    setState(() => _showDelete = value);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.

            onPressed: (_) {
              final snackBar = SnackBar(
                content: const Text('Your practice has been logged!'),
                action: SnackBarAction(label: 'UNDO', onPressed: () {}),
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.check,
            label: 'Zabeleži',
          ),
        ],
      ),
      child: PopupMenuContainer<String>(
        items: const [
          PopupMenuItem(
            value: 'delete',
            child: Text('Delete permanently'),
          ),
        ],
        onItemSelected: (value) async {
          if (value == 'delete') {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Brisanje stavke'),
                content:
                    Text('Da li ste sigurni da ovu stavku želite da obrišete?'),
                actions: [
                  TextButton(
                      child: Text('NE'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }),
                  TextButton(
                      child: Text('DA'),
                      onPressed: () async {
                        await context
                            .read<SkillListProvider>()
                            .deleteSkill(id: widget.id);
                        Navigator.of(context).pop(true);
                      }),
                ],
              ),
            );
          }
        },
        child: SkillListTileBody(
          index: widget.index,
          textWidget: Text(widget.description),
          trailingWidget: const Icon(Icons.chevron_left),
          leadingWidget: showDelete
              ? const Icon(Icons.delete)
              : Text(
                  widget.index.toString().padLeft(2, '0'),
                ),
        ),
      ),
    );
  }
}
