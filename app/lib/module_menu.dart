import 'package:app/constants.dart';
import "package:flutter/material.dart";
import "package:app/skills_group_card.dart";

class ModuleMenu extends StatelessWidget {
  final List<SkillsGroups> skillsGroup;
  final String name;
  const ModuleMenu({required this.name, required this.skillsGroup, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        child: Text(
          name,
          style: const TextStyle(fontSize: 28),
        ),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
      ),
      ...skillsGroup
          .map((e) => SkillsGroupCard(
                title: e.title,
                subtitle: e.subtitle,
              ))
          .toList(),
    ]);
  }
}
