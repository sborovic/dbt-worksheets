import 'package:app/widgets/skill_list_tile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SkillListTile extends StatelessWidget {
  final String description;
  final int index;

  const SkillListTile(
      {required this.description, required this.index, Key? key})
      : super(key: key);

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
      child: SkillListTileBody(
        index: index,
        textWidget: Text(description),
        trailingWidget: const Icon(Icons.chevron_left),
      ),
    );
  }
}
