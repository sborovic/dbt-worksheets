import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SkillListTileEditable extends StatelessWidget {
  final int index;
  final VoidCallback showButton;
  const SkillListTileEditable(
      {required this.showButton, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              index.toString().padLeft(2, '0'),
            ),
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const TextField(
                maxLines: 3,
                minLines: 1,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: [
              const Icon(Icons.add),
              const SizedBox(width: 10),
              IconButton(icon: const Icon(Icons.delete), onPressed: showButton),
            ]),
          ),
        ],
      ),
    );
  }
}
