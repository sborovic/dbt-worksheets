import 'dart:developer';
import 'dart:io';

import 'package:app/db.dart';
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
  bool isOpened = false;

  SkillListTile(
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

            onPressed: (_) async {
              final id = await context.read<SkillListProvider>().logPractice(
                  widget.id, DateTime.now().millisecondsSinceEpoch);
              final snackBar = SnackBar(
                content: const Text('Uspešno zabeleženo!'),
                action: SnackBarAction(
                    label: 'PONIŠTI',
                    onPressed: () async {
                      await SqliteDb().deleteFromLogs(id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Beleženje je poništeno!'),
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
            label: 'Zabeleži',
          ),
        ],
      ),
      child: PopupMenuContainer<String>(
        items: const [
          PopupMenuItem(
            value: 'delete',
            child: Text('Obriši'),
          ),
        ],
        onItemSelected: (value) async {
          if (value == null) return;
          if (value == 'delete') {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Brisanje stavke'),
                content: const Text(
                    'Da li ste sigurni da želite da obrišete ovu stavku? PAŽNJA: Brisanje je nepovratno!'),
                actions: [
                  TextButton(
                      child: const Text('NE'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }),
                  TextButton(
                      child: const Text('DA'),
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
              widget.isOpened
                  ? controller.close()
                  : controller.openEndActionPane();
              widget.isOpened ^= true;
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
