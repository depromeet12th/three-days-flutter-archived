import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:three_days/domain/habit/clap/clap_repository.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/domain/habit/habit_service.dart';
import 'package:three_days/domain/habit/history/habit_history_repository.dart';
import 'package:three_days/ui/habit/habit_widget.dart';
import 'package:three_days/ui/mate/mate_page.dart';

class HabitListPage extends StatefulWidget {
  HabitListPage({super.key});

  final HabitRepository habitRepository = HabitRepository();
  final HabitHistoryRepository habitHistoryRepository = HabitHistoryRepository();
  final ClapRepository clapRepository = ClapRepository();
  final HabitService habitService = HabitService();

  @override
  State<StatefulWidget> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  late List<Habit> habits = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final habitList = await widget.habitRepository.findAll();
    setState(() {
      habits.addAll(habitList);
    });

    if (kDebugMode) {
      print('habits: $habits');
      print('habitHistories: ${await widget.habitHistoryRepository.findAll()}');
      print('claps: ${await widget.clapRepository.findAll()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(73),
          child: AppBar(
            title: Text(
              _getFormattedDate(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/notification');
                },
                // TODO: 벨모양 아이콘 적용
                icon: Icon(Icons.add),
              ),
            ],
            backgroundColor: Color(0xFFF4F6F8),
          ),
        ),
        body: Container(
          color: Color(0xFFF4F6F8),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 20.0,
              right: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getWidgets(),
              ),
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
              icon: Icon(Icons.access_alarm_outlined),
              label: '짝궁',
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
                Navigator.of(context).pushReplacementNamed(MatePage.routeName);
                break;
              case 3:
                Navigator.of(context).pushReplacementNamed('/mypage');
                break;
            }
          },
        ),
      ),
    );
  }

  String _getFormattedDate() {
    return DateFormat('MM월 dd일 E요일', 'ko').format(DateTime.now());
  }

  List<Widget> _getWidgets() {
    final List<Widget> widgets = habits.map((e) => HabitWidget(
      habit: e,
      onKebabMenuPressed: _showModalBottomSheet,
    )).toList();
    // FIXME: 목록 맨밑에 추가버튼 있어야함
    // widgets.add(InitialHabit());
    return widgets;
  }

  /// habit_widget 에서 호출하는 콜백 메서드.
  /// 업데이트 / 삭제하고나서 목록을 갱신하기 위해 사용함
  void _showModalBottomSheet(BuildContext context, Habit goal) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SvgPicture.asset(
                    'images/icon_pencil.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                title: const Text(
                  '수정하기',
                  style: TextStyle(
                    color: Color.fromRGBO(0x73, 0x73, 0x73, 1.0),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    '/habit/edit',
                    arguments: goal,
                  );
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).pop(GoalActionType.edit);
                },
              ),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SvgPicture.asset(
                    'images/icon_bin.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                title: const Text(
                  '삭제하기',
                  style: TextStyle(
                    color: Color.fromRGBO(0x73, 0x73, 0x73, 1.0),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  showDialog<DeleteActionType>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      titlePadding: const EdgeInsets.only(top: 40),
                      title: const Text(
                        '정말 삭제하시겠어요?',
                        textAlign: TextAlign.center,
                      ),
                      content: const Text(
                        '목표를 삭제하게되면\n히스토리까지 모두 삭제되며 복구되지 않아요',
                        textAlign: TextAlign.center,
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(0xEF, 0xEF, 0xEF, 1.0),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pop(DeleteActionType.cancel),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Text(
                              '그냥 둘게요',
                              style: TextStyle(
                                color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pop(DeleteActionType.delete),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Text('삭제할게요'),
                          ),
                        ),
                      ],
                      insetPadding: const EdgeInsets.symmetric(vertical: 28),
                    ),
                  ).then((value) async {
                    if (value != null && value == DeleteActionType.delete) {
                      await widget.habitService.delete(goal.habitId);
                      if (!mounted) {
                        return;
                      }
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
          habits.remove(goal);
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
