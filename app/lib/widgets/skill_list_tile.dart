// Dart imports:

// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:app/db.dart';
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/popup_menu_container.dart';
import 'package:app/widgets/skill_list_tile_body.dart';

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
      groupTag: 'all',
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.

            onPressed: (_) async {
              final id = await context.read<SkillListProvider>().logPractice(
                  widget.id, DateTime.now().millisecondsSinceEpoch);
              final snackBar = SnackBar(
                content: const Text('snackBarLogSuccessful').tr(),
                action: SnackBarAction(
                    label: 'snackBarUndo'.tr(),
                    onPressed: () async {
                      await SqliteDb().deleteFromLogs(id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('snackBarUndone').tr(),
                        ),
                      );
                    }),
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.check,
            label: 'slidableLog'.tr(),
          ),
        ],
      ),
      child: PopupMenuContainer<String>(
        items: [
          PopupMenuItem(
            value: 'delete',
            child: const Text('popupMenuDelete').tr(),
          ),
        ],
        onItemSelected: (value) async {
          if (value == null) return;
          if (value == 'delete') {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('dialogDelete'),
                content: const Text('dialogAreYouSure').tr(),
                actions: [
                  TextButton(
                      child: const Text('buttonNo').tr(),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }),
                  TextButton(
                      child: const Text('buttonYes').tr(),
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
        child: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              final controller = Slidable.of(context)!;
              Slidable.of(context)!.ratio < 0
                  ? controller.close()
                  : controller.openEndActionPane();
            },
            child: SkillListTileBody(
              index: widget.index,
              textWidget: Text(widget.description),
              trailingWidget: const Icon(Icons.chevron_left),
            ),
          );
        }),
      ),
    );
  }
}
