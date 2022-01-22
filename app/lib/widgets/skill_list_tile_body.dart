import 'package:flutter/material.dart';

class SkillListTileBody extends StatelessWidget {
  final int index;
  final Widget textWidget;
  final Widget trailingWidget;
  final Widget leadingWidget;
  const SkillListTileBody(
      {required this.index,
      required this.textWidget,
      required this.trailingWidget,
      required this.leadingWidget,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: leadingWidget,
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              // child: Text(description),
              child: textWidget,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            //  child: const Icon(Icons.chevron_left),
            child: trailingWidget,
          ),
        ],
      ),
    );
  }
}
