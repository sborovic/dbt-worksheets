import 'package:app/constants.dart';
import "package:flutter/material.dart";
import "package:app/skills_group_card.dart";

class ModuleMenu extends StatelessWidget {
  final List<SkillsGroups> mindfulnessList;
  const ModuleMenu(this.mindfulnessList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: mindfulnessList
          .map((e) => SkillsGroupCard(
                title: e.title,
                subtitle: e.subtitle,
              ))
          .toList(),
    );
  }
}
