import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_days/design/three_days_colors.dart';
import 'package:three_days/domain/goal/goal.dart';
import 'package:three_days/domain/goal/goal_repository.dart';
import 'package:three_days/ui/form/sub_title_text.dart';
import 'package:three_days/ui/form/three_days_date_range_field.dart';
import 'package:three_days/ui/form/three_days_text_form_field.dart';
import 'package:three_days/ui/form/time_selector_widget.dart';

class GoalAddPage extends StatefulWidget {
  GoalAddPage({super.key});

  final GoalRepository goalRepository = GoalRepository();

  @override
  State<StatefulWidget> createState() => _GoalAddPageState();
}

class _GoalAddPageState extends State<GoalAddPage> {
  static const maxLengthOfTitle = 15;
  static const maxLengthOfNotificationContent = 20;

  bool dateRangeEnabled = false;
  bool timeRangeEnabled = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay? remindTime;
  TimeOfDay? notificationTime;
  bool canSubmit = false;

  final goalTextEditingController = TextEditingController();

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
                onPressed: !canSubmit
                    ? null
                    : () async {
                  final goal = await widget.goalRepository.save(
                    Goal(
                      title: goalTextEditingController.value.text,
                    ),
                  );
                  if (kDebugMode) {
                    print('createdGoal: $goal');
                  }
                  if (!mounted) {
                    return;
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/goal/list',
                        (route) => route.settings.name == '/goal/list',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThreeDaysColors.primary,
                  minimumSize: const Size.fromHeight(50),
                ),
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 35,
            ),

            /// 목표
            const ThreeDaysSubTitleText(data: '목표'),
            ThreeDaysTextFormField(
              controller: goalTextEditingController,
              hintText: '짝심목표를 알려주세요',
              maxLength: maxLengthOfTitle,
              onChanged: (value) {
                setState(() {
                  canSubmit = value.isNotEmpty;
                });
              },
            ),
            const SizedBox(height: 25),

            /// 목표 기간
            Row(
              children: [
                const ThreeDaysSubTitleText(data: '목표 기간'),
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
            ThreeDaysDateRangeField(
              visible: dateRangeEnabled,
              startDate: startDate,
              endDate: endDate,
            ),

            /// 수행 시간
            Row(
              children: [
                const ThreeDaysSubTitleText(data: '수행 시간'),
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
            const ThreeDaysSubTitleText(data: 'Push 알림 설정'),
            const SizedBox(
              height: 5,
            ),
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
            const ThreeDaysTextFormField(
              hintText: 'Push 알림 내용을 입력해주세요',
              maxLength: maxLengthOfNotificationContent,
            ),
          ],
        ),
      ),
    );
  }
}
