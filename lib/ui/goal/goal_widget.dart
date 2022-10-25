import 'package:flutter/material.dart';
import 'package:three_days/domain/goal/goal.dart';
import 'package:three_days/domain/goal/goal_repository.dart';
import 'package:three_days/domain/goal/goal_service.dart';

class GoalWidget extends StatefulWidget {
  GoalWidget({
    super.key,
    required this.goal,
    required this.onKebabMenuPressed,
  });

  final Goal goal;
  final GoalRepository goalRepository = GoalRepository();
  final GoalService goalService = GoalService();
  final void Function(BuildContext context, Goal goal) onKebabMenuPressed;

  @override
  State<StatefulWidget> createState() {
    return _GoalWidgetState();
  }
}

class _GoalWidgetState extends State<GoalWidget> {
  late Goal goal;
  int countOfHistories = 0;

  @override
  void initState() {
    super.initState();
    goal = widget.goal;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final count = await widget.goalService.countHistories(goal.goalId);
    setState(() {
      countOfHistories = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color.fromRGBO(0xED, 0xF6, 0xFF, 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: const Color.fromRGBO(0xD3, 0xE5, 0xFF, 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 12.5),
                    child: Text(
                      '짝심 $countOfHistories일',
                      style: const TextStyle(
                        color: Color.fromRGBO(0x3F, 0x80, 0xFF, 1.0),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        widget.onKebabMenuPressed.call(context, widget.goal);
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Color.fromRGBO(0xA6, 0xA6, 0xA6, 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.goal.title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                _clapWidget(
                  checked: widget.goal.isChecked(0),
                  focused: widget.goal.isFocused(0),
                ),
                const Spacer(),
                _clapWidget(
                  checked: widget.goal.isChecked(1),
                  focused: widget.goal.isFocused(1),
                ),
                const Spacer(),
                _clapWidget(
                  checked: widget.goal.isChecked(2),
                  focused: widget.goal.isFocused(2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// checked: 오늘꺼 체크 했는지
  /// focused: 오늘껀지
  Widget _clapWidget({
    required bool checked,
    bool focused = false,
  }) {
    final backgroundColor =
        checked ? Colors.white : const Color.fromRGBO(220, 229, 238, 1.0);
    return GestureDetector(
      onTapUp: (details) async {
        if (!focused) {
          return;
        }
        if (widget.goal.clapChecked) {
          widget.goal.setUnchecked();
          await widget.goalService.uncheck(widget.goal);
        } else {
          widget.goal.setChecked();
          final clap = await widget.goalService.check(widget.goal);
          if (clap != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  '짝심삼일 완료!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                content: const Text(
                  '3일동안 목표를 달성한 나를 위해\n박수를 쳐주세요. 짝짝짝!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('잘했어요'),
                  ),
                ],
              ),
            );
          }
        }
        final count = await widget.goalService.countHistories(goal.goalId);
        setState(() {
          countOfHistories = count;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            /// XXX: 테두리가 안쪽으로 그려지지 않아서 선택되지 않은 항목은 배경색이랑 같은 테두리를 그림
            border: Border.all(
              color: focused
                  ? const Color.fromRGBO(0x74, 0xA3, 0xFF, 1.0)
                  : backgroundColor,
              strokeAlign: BorderSide.strokeAlignInside,
              width: 3.0,
            )),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Image.asset(
            checked ? 'images/clap_checked.png' : 'images/clap_unchecked.png',
          ),
        ),
      ),
    );
  }
}
