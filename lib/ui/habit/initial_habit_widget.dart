import 'package:flutter/material.dart';

class InitialHabit extends StatelessWidget {
  const InitialHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        Navigator.of(context).pushNamed('/habit/add');
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0xF9, 0xFA, 0xFB, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 56),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFD8DCE2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(
                  Icons.add,
                  color: Color(0xFF8E95A3),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text('습관 만들기'),
            ],
          ),
        ),
      ),
    );
  }
}
