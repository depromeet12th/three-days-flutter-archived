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
      Goal(goalId: 1,
          title: '이불 정리하기',
          days: 1, clapIndex: 2, clapChecked: true,),
      Goal(
        goalId: 2,
        title: '일어나자마자 물 마시기',
        days: 3,
      ),
      Goal(
        goalId: 3,
        title: '코딩테스트 1문제 풀기',
        days: 2,
        clapIndex: 1,
      ),
      Goal(
        goalId: 4,
        title: '샐러드 먹기',
        days: 10,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color.fromRGBO(0xFF, 0xFF, 0xFF, 1.0),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
            ),
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
                      children: [
                        const Text(
                          '작심삼일에서\n작심삼백일까지 함께해요.',
                          style: TextStyle(
                            color: Color.fromRGBO(0x1A, 0x1F, 0x27, 1.0),
                            fontSize: 22,
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: goals.isNotEmpty,
                          child: GestureDetector(
                            onTapUp: (_) {
                              Navigator.of(context).pushNamed('/goal/add');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color:
                                    const Color.fromRGBO(0xF0, 0xF0, 0xF0, 1.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: _getGoals(goals),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_rounded),
              label: '통계',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                break;
              case 1:
                Navigator.of(context).pushReplacementNamed('/statistics');
                break;
              case 2:
                Navigator.of(context).pushReplacementNamed('/mypage');
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _getGoals(List<Goal> goals) {
    if (goals.isEmpty) {
      return const InitialGoal();
    } else {
      return ListView.separated(
        scrollDirection: Axis.vertical,
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
