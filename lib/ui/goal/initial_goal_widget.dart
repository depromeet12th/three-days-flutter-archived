import 'package:three_days/design/three_days_colors.dart';
import 'package:flutter/material.dart';

class InitialGoal extends StatelessWidget {
  const InitialGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0xF9, 0xFA, 0xFB, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('images/initial_clap.png'),
              const SizedBox(height: 10),
              const Text(
                '짝심삼일 시작해보실래요?',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '3일을 채울 때 마다 짝! 박수를 쳐드려요',
                style: TextStyle(
                  color: Color.fromRGBO(0x75, 0x75, 0x75, 1.0),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/goal/add');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThreeDaysColors.primary,
                ),
                child: const Text('목표 만들기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
