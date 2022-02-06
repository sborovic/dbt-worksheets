// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';

class PopupMenuContainer<T> extends StatefulWidget {
  final Widget child;
  final List<PopupMenuEntry<T>> items;
  final void Function(T?) onItemSelected;

  const PopupMenuContainer(
      {required this.child,
      required this.items,
      required this.onItemSelected,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupMenuContainerState<T>();
}

class PopupMenuContainerState<T> extends State<PopupMenuContainer<T>> {
  Offset? _tapDownPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressDown: (LongPressDownDetails details) {
          _tapDownPosition = details.globalPosition;
        },
        onLongPress: () async {
          final RenderBox overlay =
              Overlay.of(context)!.context.findRenderObject() as RenderBox;

          T? value = await showMenu<T>(
            context: context,
            items: widget.items,
            position:
                // RelativeRect.fromLTRB(
                //   _tapDownPosition!.dx,
                //   _tapDownPosition!.dy,
                //   overlay.size.width - _tapDownPosition!.dx,
                //   overlay.size.height - _tapDownPosition!.dy,
                // ),
                RelativeRect.fromRect(
                    _tapDownPosition! &
                        const Size(40, 40), // smaller rect, the touch area
                    Offset.zero & overlay.size // Bigger rect, the entire screen
                    ),
          );

          widget.onItemSelected(value);
        },
        child: widget.child);
  }
}
