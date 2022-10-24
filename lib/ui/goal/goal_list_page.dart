import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_days/domain/goal/goal.dart';
import 'package:three_days/domain/goal/goal_repository.dart';
import 'package:three_days/ui/goal/goal_widget.dart';
import 'package:three_days/ui/goal/initial_goal_widget.dart';

class GoalListPage extends StatefulWidget {
  GoalListPage({super.key});

  final GoalRepository goalRepository = GoalRepository();

  @override
  State<StatefulWidget> createState() => _GoalListPageState();
}

class _GoalListPageState extends State<GoalListPage> {
  late List<Goal> goals = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final goalList = await widget.goalRepository.findAll();
    setState(() {
      goals.addAll(goalList);
    });
    if (kDebugMode) {
      print('goals: $goals');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      _getFormattedDate(),
                      style: const TextStyle(
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
              icon: ImageIcon(
                AssetImage('images/icon_home.png'),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/icon_statistics.png'),
              ),
              label: '통계',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/icon_mypage.png'),
              ),
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
      return Column(
        children: const [
          InitialGoal(),
        ],
      );
    }
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: goals.length,
      itemBuilder: (BuildContext context, int index) => GoalWidget(
        goal: goals[index],
        onKebabMenuPressed: _showModalBottomSheet,
      ),
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
    );
  }

  String _getFormattedDate() {
    /// TODO: current locale
    final formatted = DateFormat('MM. dd. (E)').format(DateTime.now());
    return formatted;
  }

  /// goal_widget 에서 호출하는 콜백 메서드.
  /// 업데이트 / 삭제하고나서 목록을 갱신하기 위해 사용함
  void _showModalBottomSheet(BuildContext context, Goal goal) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(
                  '수정하기',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    '/goal/edit',
                    arguments: goal,
                  );
                  Navigator.of(context).pop(GoalActionType.edit);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text(
                  '삭제하기',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  showDialog<DeleteActionType>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        '정말 삭제하시겠어요?',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      content: const Text(
                        '목표를 삭제하게되면\n히스토리까지 모두 삭제되며 복구되지 않아요',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(0xEF, 0xEF, 0xEF, 1.0),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pop(DeleteActionType.cancel),
                          child: const Text(
                            '그냥 둘게요',
                            style: TextStyle(
                              color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pop(DeleteActionType.delete),
                          child: const Text('삭제할게요'),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value != null && value == DeleteActionType.delete) {
                      widget.goalRepository.deleteById(goal.goalId);
                      Navigator.of(context).pop(GoalActionType.delete);
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      GoalActionType? result = value as GoalActionType?;
      if (result == null) {
        return;
      }
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: Color.fromRGBO(0x00, 0xAE, 0x5A, 1.0),
                ),
                Text(
                    '짝심목표가 ${result == GoalActionType.edit ? '수정' : '삭제'}되었어요'),
              ],
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      if (result == GoalActionType.delete) {
        setState(() {
          goals.remove(goal);
        });
      }
    });
  }
}

enum GoalActionType {
  add,
  edit,
  delete,
}

enum DeleteActionType {
  delete,
  cancel,
}