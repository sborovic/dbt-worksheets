// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list.dart';

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
          return SlidableAutoCloseBehavior(
            closeWhenTapped: false,
            child: SkillList(skillNodes: provider.items),
          );
        },
      ),
    );
  }
}
