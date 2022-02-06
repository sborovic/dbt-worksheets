// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list.dart';

class ExpansionTileWrapper extends StatefulWidget {
  const ExpansionTileWrapper({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<ExpansionTileWrapper> createState() => _ExpansionTileWrapperState();
}

class _ExpansionTileWrapperState extends State<ExpansionTileWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpansionTile(
      title: Text(widget.title),
      children: <Widget>[
        Consumer<SkillListProvider>(builder: (_, provider, __) {
          return SkillList(
            skillNodes: provider.items,
          );
        })
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
