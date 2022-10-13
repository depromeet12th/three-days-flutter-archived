import 'package:flutter/material.dart';

class GoalAddPage extends StatefulWidget {
  const GoalAddPage({super.key});

  @override
  State<StatefulWidget> createState() => _GoalAddPageState();
}

class _GoalAddPageState extends State<GoalAddPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('목표 생성하기'),
            const Text('목표명'),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '최대 20자',
              ),
            ),
            const Text('기간'),
            const Text('2022-01-01 ~ 2022-12-31'),
            const Text('수행시간'),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '최대 20자',
              ),
            ),
            const Text('Push 알림 설정'),
            TextFormField(
              decoration: const InputDecoration(
                hintText: '푸쉬알림 내용',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
