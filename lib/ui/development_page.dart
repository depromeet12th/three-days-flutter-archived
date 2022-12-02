import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:three_days/domain/goal/goal_service.dart';

/// 개발, 테스트 편의 기능 모음
class DevelopmentPage extends StatelessWidget {
  DevelopmentPage({super.key});

  final _goalService = GoalService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('테스트 편의 기능'),
          foregroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final fcmToken = await FirebaseMessaging.instance.getToken();
                  await Clipboard.setData(ClipboardData(text: fcmToken));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("FCM Token 이 클립보드에 복사되었습니다."),
                  ));
                },
                child: const Text('FCM Token 복사하기'),
              ),
              ElevatedButton(
                onPressed: () async {
                  const String title = '이불 정리하기';
                  await _goalService.createForContinuousDays(title, 2);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: const [
                        Icon(
                          Icons.check,
                          color: Color.fromRGBO(0x00, 0xAE, 0x5A, 1.0),
                        ),
                        Text('짝심목표가 등록되었어요'),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                },
                child: const Text('테스트 데이터 추가'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
