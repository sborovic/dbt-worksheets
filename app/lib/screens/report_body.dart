import 'package:app/providers/skill_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<SkillListProvider>().generateReport(1, 2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.map((map) {
                return Text(map['description'] as String);
              }).toList(),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
