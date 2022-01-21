import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list.dart';
import 'package:flutter/material.dart';

import 'package:app/models/skill_node.dart';
import 'package:provider/provider.dart';

class SkillListScreen extends StatelessWidget {
  final String appBarTitle;
  const SkillListScreen({
    required this.appBarTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Consumer<SkillListProvider>(
        builder: (_, provider, __) {
          return SkillList(skillNodes: provider.items);
        },
      ),
    );
  }
}
