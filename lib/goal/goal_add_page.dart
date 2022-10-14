import 'package:flutter/material.dart';

class GoalAddPage extends StatefulWidget {
  const GoalAddPage({super.key});

  @override
  State<StatefulWidget> createState() => _GoalAddPageState();
}

class _GoalAddPageState extends State<GoalAddPage> {
  bool dateRangeEnabled = false;
  bool timeRangeEnabled = false;

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
              child: _getFormWidgets(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
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

  Widget _getFormWidgets() {
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
                      color: Color.fromRGBO(0xF9, 0xFa, 0xFB, 1.0),
                    ),
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          Text('시작'),
                          Spacer(),
                          Text('2022. 10. 13.'),
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
                        children: const [
                          Text('종료'),
                          Spacer(),
                          Text('2022. 10. 13.'),
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
            Visibility(
              visible: timeRangeEnabled,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: '시간을 선택해주세요',
                ),
              ),
            ),
            const SizedBox(height: 25),

            /// Push 알림 설정
            const Text(
              'Push 알림 설정',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '시간을 선택해주세요',
              ),
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
}
