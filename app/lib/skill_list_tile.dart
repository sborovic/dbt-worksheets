import 'package:flutter/material.dart';

class SkillListTile extends StatelessWidget {
  final String description;
  final int index;
  const SkillListTile({required this.description, required this.index, Key? key})
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
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(description),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
