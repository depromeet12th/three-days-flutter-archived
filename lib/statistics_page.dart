import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Center(
          child: Text('Statistics Page'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_rounded),
              label: '통계',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '마이페이지',
            ),
          ],
          onTap: (value) {
            switch (value) {
              case 0:
                Navigator.of(context).pushReplacementNamed('/goal/list');
                break;
              case 1:
                break;
              case 2:
                Navigator.of(context).pushReplacementNamed('/mypage');
                break;
            }
          },
          currentIndex: 1,
        ),
      ),
    );
  }
}
