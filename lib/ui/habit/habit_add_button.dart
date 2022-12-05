import 'package:flutter/material.dart';

class HabitAddButton extends StatefulWidget {
  const HabitAddButton({
    super.key,
    required this.visible,
  });

  final bool visible;

  @override
  State<StatefulWidget> createState() => _HabitAddButtonState();
}

class _HabitAddButtonState extends State<HabitAddButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: widget.visible,
      child: GestureDetector(
        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
          Navigator.of(context).pushNamed('/habit/add');
        },
        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isPressed
                ? const Color.fromRGBO(0xD4, 0xD4, 0xD4, 1.0)
                : const Color.fromRGBO(0xF0, 0xF0, 0xF0, 1.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(14.0),
            child: Icon(
              Icons.add,
              color: Color.fromRGBO(0x2D, 0x2E, 0x36, 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
