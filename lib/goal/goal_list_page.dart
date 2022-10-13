import 'package:flutter/material.dart';
import 'package:three_days/goal/goal.dart';
import 'package:three_days/goal/goal_widget.dart';
import 'package:three_days/goal/initial_goal.dart';

class GoalListPage extends StatelessWidget {
  const GoalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Goal> goals = [];
    // final List<Goal> goals = [
    //   Goal(
    //     title: '이불 정리하기',
    //     days: 1,
    //   ),
    //   Goal(
    //     title: '일어나자마자 물 마시기',
    //     days: 3,
    //   ),
    // ];

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color.fromRGBO(0xFF, 0xFF, 0xFF, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // TODO: 현재 날짜
                    // TODO: Formatting
                    Text(
                      '10.13 (목)',
                      style: TextStyle(
                        color: Color.fromRGBO(0x8F, 0x8F, 0x8F, 1.0),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '작심삼일에서\n작심삼백일까지 함께해요',
                      style: TextStyle(
                        color: Color.fromRGBO(0x1A, 0x1F, 0x27, 1.0),
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _getGoals(goals),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getGoals(List<Goal> goals) {
    if (goals.isEmpty) {
      return const InitialGoal();
    } else {
      return Column(
        children: goals.map((e) => GoalWidget(goal: e)).toList(),
      );
    }
  }
}
