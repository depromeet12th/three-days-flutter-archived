import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_days/goal/form/time_selector_widget.dart';
import 'package:three_days/goal/goal.dart';
import 'package:three_days/goal/goal_repository.dart';

class GoalAddPage extends StatefulWidget {
  GoalAddPage({super.key});

  final GoalRepository goalRepository = GoalRepository();

  @override
  State<StatefulWidget> createState() => _GoalAddPageState();
}

class _GoalAddPageState extends State<GoalAddPage> {
  bool dateRangeEnabled = false;
  bool timeRangeEnabled = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay? remindTime;
  TimeOfDay? notificationTime;

  final goalTextEditingController = TextEditingController();

  /// TODO: textField 현재글자수 표시, 글자수 제한
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            /// 닫기 버튼
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Expanded(
              child: _getFormWidgets(context),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  final goal = await widget.goalRepository.save(
                    Goal(
                      title: goalTextEditingController.value.text,
                      days: 1,
                    ),
                  );
                  if (kDebugMode) {
                    print('createdGoal: $goal');
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/goal/list',
                    (route) => route.settings.name == '/goal/list',
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                // TODO: form 입력 상태 따라서 enabled 제어
                child: const Text(
                  '목표 만들기',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFormWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '짝심목표 만들기',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 35,
            ),

            /// 목표
            const Text(
              '목표',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '짝심목표를 알려주세요',
              ),
              controller: goalTextEditingController,
            ),
            const SizedBox(height: 25),

            /// 목표 기간
            Row(
              children: [
                const Text(
                  '목표 기간',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: dateRangeEnabled,
                  onChanged: (value) {
                    setState(() {
                      dateRangeEnabled = value;
                    });
                  },
                )
              ],
            ),
            // TODO: 시작, 종료 시각 사이 선 긋기
            Visibility(
              visible: dateRangeEnabled,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                      ),
                      color: Color.fromRGBO(0xF9, 0xFA, 0xFB, 1.0),
                    ),
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Text('시작'),
                          const Spacer(),
                          Text(_getFormattedDate(startDate)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.0),
                      ),
                      color: Color.fromRGBO(0xF9, 0xFa, 0xFB, 1.0),
                    ),
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Text('종료'),
                          const Spacer(),
                          Text(_getFormattedDate(endDate)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),

            /// 수행시간
            Row(
              children: [
                const Text(
                  '수행시간',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: timeRangeEnabled,
                  onChanged: (value) {
                    setState(() {
                      timeRangeEnabled = value;
                    });
                  },
                ),
              ],
            ),
            TimeSelectorWidget(
              visible: timeRangeEnabled,
              onTabInside: (event) async {
                var pickedTime = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                );
                setState(() {
                  remindTime = pickedTime;
                  if (kDebugMode) {
                    print(remindTime);
                  }
                });
              },
              timeOfDay: remindTime,
            ),
            const SizedBox(height: 25),

            /// Push 알림 설정
            const Text(
              'Push 알림 설정',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5,),
            TimeSelectorWidget(
              visible: true,
              onTabInside: (event) async {
                var pickedTime = await showTimePicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                );
                setState(() {
                  notificationTime = pickedTime;
                  if (kDebugMode) {
                    print(notificationTime);
                  }
                });
              },
              timeOfDay: notificationTime,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Push 알림 내용을 입력해주세요',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(DateTime dateTime) {
    return DateFormat('yyyy. MM. dd.').format(dateTime);
  }
}
