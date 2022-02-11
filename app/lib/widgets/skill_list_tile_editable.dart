// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/src/provider.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list_tile_body.dart';

class SkillListTileEditable extends StatelessWidget {
  final int index;
  final VoidCallback showButton;
  SkillListTileEditable(
      {required this.showButton, required this.index, Key? key})
      : super(key: key);
  final descriptionInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SkillListTileBody(
      index: index,
      textWidget: TextField(
        controller: descriptionInput,
        minLines: 1,
        maxLines: 3,
      ),
      trailingWidget: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context
                    .read<SkillListProvider>()
                    .insertSkill(title: '', description: descriptionInput.text);
              }),
          const SizedBox(width: 10),
          IconButton(icon: const Icon(Icons.close), onPressed: showButton),
        ],
      ),
    );
  }
}
