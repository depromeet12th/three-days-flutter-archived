import 'package:flutter/material.dart';
import 'package:three_days/goal/goal.dart';

class GoalWidget extends StatefulWidget {
  const GoalWidget({
    super.key,
    required this.goal,
  });

  final Goal goal;

  @override
  State<StatefulWidget> createState() {
    return _GoalWidgetState();
  }
}

class _GoalWidgetState extends State<GoalWidget> {
  late Goal goal;

  @override
  void initState() {
    super.initState();
    goal = widget.goal;
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
                      '짝심 ${widget.goal.days}일',
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
                        _showModalBottomSheet(context);
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
                color: Color.fromRGBO(0x1A, 0x1F, 0x27, 1.0),
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
      onTapUp: (details) {
        if (!focused) {
          return;
        }
        setState(() {
          if (widget.goal.clapChecked) {
            widget.goal.setUnchecked();
          } else {
            widget.goal.setChecked();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            // XXX: 테두리가 안쪽으로 그려지지 않아서 선택되지 않은 항목은 배경색이랑 같은 테두리를 그림
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

  void _showModalBottomSheet(BuildContext context) {
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
                onTap: () {
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
                          onPressed: () =>
                              Navigator.of(context).pop(DeleteActionType.cancel),
                          child: const Text(
                            '그냥 둘게요',
                            style: TextStyle(
                              color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(DeleteActionType.delete),
                          child: const Text('삭제할게요'),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value != null && value == DeleteActionType.delete) {
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
    });
  }
}

enum GoalActionType {
  edit,
  delete,
}

enum DeleteActionType {
  delete,
  cancel,
}
