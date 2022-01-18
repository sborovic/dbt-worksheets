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
          // SlidableAction(
          //   onPressed: (_) {},
          //   backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          //   foregroundColor: Theme.of(context).colorScheme.onPrimary,
          //   icon: Icons.plus_one,
          //   //label: 'Done',
          // ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                index.toString().padLeft(2, '0'),
                // style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(description),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.chevron_left),
            ),
          ],
        ),
      ),
    );
  }
}
