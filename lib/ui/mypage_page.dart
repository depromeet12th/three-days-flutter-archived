import 'package:flutter/material.dart';
import 'package:three_days/domain/goal/goal_service.dart';

class MypagePage extends StatelessWidget {
  MypagePage({super.key});

  final _goalService = GoalService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              const title = '이불 정리하기';
              await _goalService.createForThirdDay(title);
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
                Navigator.of(context).pushReplacementNamed('/goal/list');
                break;
              case 1:
                Navigator.of(context).pushReplacementNamed('/statistics');
                break;
              case 2:
                break;
            }
          },
          currentIndex: 2,
        ),
      ),
    );
  }
}
