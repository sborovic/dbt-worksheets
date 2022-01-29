import 'package:app/providers/skill_list_provider.dart';
import 'package:app/widgets/skill_list_tile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/src/provider.dart';

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
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 25),
//             child: Text(
//               index.toString().padLeft(2, '0'),
//             ),
//           ),
//           Flexible(
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: const TextField(
//                 maxLines: 3,
//                 minLines: 1,
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerRight,
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(children: [
//               const Icon(Icons.add),
//               const SizedBox(width: 10),
//               IconButton(icon: const Icon(Icons.delete), onPressed: showButton),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
