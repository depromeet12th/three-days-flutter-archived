import 'package:flutter/material.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/domain/habit/habit_service.dart';

class HabitWidget extends StatefulWidget {
  HabitWidget({
    super.key,
    required this.habit,
    required this.onKebabMenuPressed,
  });

  final Habit habit;
  final HabitRepository habitRepository = HabitRepository();
  final HabitService habitService = HabitService();
  final void Function(BuildContext context, Habit habit) onKebabMenuPressed;

  @override
  State<StatefulWidget> createState() {
    return _HabitWidgetState();
  }
}

class _HabitWidgetState extends State<HabitWidget> {
  late Habit habit;
  int countOfHistories = 0;
  bool hasCheckedAtToday = false;

  // TODO: 23:59:59 ~ 00:00:00 처럼 날짜 바뀔 때 포커싱도 바뀌어야함
  int focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    habit = widget.habit;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final count = await widget.habitService.countHistories(habit.habitId);
    final isChecked = await widget.habitService.isCheckedDateAt(
      habit.habitId,
      DateTime.now(),
    );
    final clapIndex = await widget.habitService.calculateClapIndex(
      habit,
      DateTime.now(),
    );
    setState(() {
      countOfHistories = count;
      hasCheckedAtToday = isChecked;
      focusedIndex = clapIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: IconButton(
              onPressed: () {
                widget.onKebabMenuPressed.call(context, widget.habit);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Color.fromRGBO(0xA6, 0xA6, 0xA6, 1.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🎯'),
                    SizedBox(width: 6),
                    Text(
                      widget.habit.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_alarm_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text('5개'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('|'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('월,수,금'),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _clapWidget(
                      checked: widget.habit
                          .isChecked(0, focusedIndex, hasCheckedAtToday),
                      focused: 0 == focusedIndex,
                      sequence: 1,
                    ),
                    SizedBox(width: 16),
                    _clapWidget(
                      checked: widget.habit
                          .isChecked(1, focusedIndex, hasCheckedAtToday),
                      focused: 1 == focusedIndex,
                      sequence: 2,
                    ),
                    SizedBox(width: 16),
                    _clapWidget(
                      checked: widget.habit
                          .isChecked(2, focusedIndex, hasCheckedAtToday),
                      focused: 2 == focusedIndex,
                      sequence: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// checked: 오늘꺼 체크 했는지
  /// focused: 오늘껀지
  Widget _clapWidget({
    required bool checked,
    required int sequence,
    bool focused = false,
  }) {
    final primary = Color(0xFF34C185);
    final backgroundColor = checked ? primary : Color(0xFFDFF5EC);
    return GestureDetector(
      onTapUp: (details) async {
        if (!focused) {
          return;
        }
        final isChecked = await widget.habitService.isCheckedDateAt(
          widget.habit.habitId,
          DateTime.now(),
        );
        if (isChecked) {
          await widget.habitService.uncheck(widget.habit);
        } else {
          final clap = await widget.habitService.check(widget.habit);
          if (clap != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                titlePadding: const EdgeInsets.only(top: 40),
                title: const Text(
                  '짝심삼일 완료!',
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  '3일동안 목표를 달성한 나를 위해\n박수를 쳐주세요. 짝짝짝!',
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 56,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('잘했어요'),
                  ),
                ],
              ),
            );
          }
        }
        final count = await widget.habitService.countHistories(habit.habitId);
        setState(() {
          countOfHistories = count;
          hasCheckedAtToday = !hasCheckedAtToday;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: !hasCheckedAtToday && focused
              ? SizedBox(
                  width: 34,
                  height: 34,
                  child: Center(
                    child: Text(
                      sequence.toString(),
                      style: TextStyle(
                        color: primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 34.0,
                ),
        ),
      ),
    );
  }
}
