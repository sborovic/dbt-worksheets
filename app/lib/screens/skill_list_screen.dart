// Flutter imports:
import 'package:app/screens/report_output_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';
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
    return ChangeNotifierProvider<ShowFABWrapper>(
      create: (_) => ShowFABWrapper(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: Text(appBarTitle)),
        body: Consumer<SkillListProvider>(
          builder: (_, provider, __) {
            return SlidableAutoCloseBehavior(
                closeWhenTapped: false,
                child: SingleChildScrollView(
                    child: Column(children: [
                  SkillList(skillNodes: provider.items),
                  const SizedBox(height: 80)
                ])));
          },
        ),
        floatingActionButton: context.watch<ShowFABWrapper>().visible
            ? FloatingActionButton.extended(
                onPressed: () {
                  ReportOutputScreen.navigateToReport(context);
                },
                icon: const Icon(Icons.text_snippet),
                label: const Text('buttonReport').tr(),
              )
            : null,
      ),
    );
  }
}

class ShowFABWrapper extends ChangeNotifier {
  int counter = 0;
  bool _visible = true;
  bool get visible {
    return _visible;
  }

  set visible(bool value) {
    if (value == true) {
      if (--counter == 0) {
        _visible = true;
        notifyListeners();
      }
    } else {
      if (counter++ == 0) {
        _visible = false;
        notifyListeners();
      }
    }
  }
}
