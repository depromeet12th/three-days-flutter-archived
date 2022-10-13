import 'package:flutter/material.dart';
import 'package:three_days/goal/goal.dart';
import 'package:three_days/goal/goal_widget.dart';
import 'package:three_days/goal/initial_goal_widget.dart';

class GoalListPage extends StatelessWidget {
  const GoalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<Goal> goals = [];
    final List<Goal> goals = [
      Goal(title: '이불 정리하기', days: 1, clapIndex: 2, clapChecked: true),
      Goal(
        title: '일어나자마자 물 마시기',
        days: 3,
      ),
    ];

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
                  children: [
                    // TODO: 현재 날짜
                    // TODO: Formatting
                    const Text(
                      '10.13 (목)',
                      style: TextStyle(
                        color: Color.fromRGBO(0x8F, 0x8F, 0x8F, 1.0),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _getTitleRowWidgets(context, goals),
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

  List<Widget> _getTitleRowWidgets(BuildContext context, List<Goal> goals) {
    List<Widget> widgets = [
      const Text(
        '작심삼일에서\n작심삼백일까지 함께해요.',
        style: TextStyle(
          color: Color.fromRGBO(0x1A, 0x1F, 0x27, 1.0),
          fontSize: 22,
        ),
      )
    ];

    if (goals.isNotEmpty) {
      widgets.add(const Spacer());
      widgets.add(
        GestureDetector(
          onTapUp: (_) {
            Navigator.of(context).pushNamed('/goal/add');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromRGBO(0xF0, 0xF0, 0xF0, 1.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(Icons.add),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _getGoals(List<Goal> goals) {
    if (goals.isEmpty) {
      return const InitialGoal();
    } else {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: goals.length,
        itemBuilder: (BuildContext context, int index) =>
            GoalWidget(goal: goals[index]),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
      );
    }
  }
}
