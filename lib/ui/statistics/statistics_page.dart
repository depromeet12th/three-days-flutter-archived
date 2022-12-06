import 'package:flutter/material.dart';
import 'package:three_days/ui/statistics/statistics_detail_page.dart';

import '../../domain/habit/habit.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({super.key});

  static const routeName = '/statistics';

  static void route(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  final gray700 = Color(0xFF353C49);
  final gray300 = Color(0xFFD8DCE2);
  final green50 = Color(0xFF34C185);
  final gray500 = Color(0xFF8E95A3);
  final gray100 = Color(0xFFF4F6F8);
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final habits = [
      Habit(title: '아침 챙겨먹기'),
      Habit(title: '점심 직후 종합 비타민'),
      Habit(title: '매주 토요일 아침 런닝'),
      Habit(title: '평일 아침 아티클 읽자!'),
      Habit(title: '우주인과 교신하기'),
      Habit(title: '아침 챙겨먹기'),
      Habit(title: '점심 직후 종합 비타민'),
      Habit(title: '매주 토요일 아침 런닝'),
      Habit(title: '평일 아침 아티클 읽자!'),
      Habit(title: '우주인과 교신하기'),
    ];

    final pageWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: gray100,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(73),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _goToTopWithAnimation();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                  ),
                ),
                Text(
                  '10월 기록',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _goToTopWithAnimation();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: gray100,
            actions: [
              Tooltip(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(
                  color: Color(0xFF5B616C),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                message: '히스토리에 저장되지 않고 삭제된 습관은\n나의 기록에서 확인할 수 없어요.🥲',
                triggerMode: TooltipTriggerMode.tap,
                child: Icon(Icons.info),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                SizedBox(
                  height: 212,
                  child: Row(
                    children: [
                      SizedBox(
                        width: (pageWidth - 52) / 2,
                        child: Column(
                          children: [
                            _getClapCount(),
                            SizedBox(height: 12),
                            _getHabitDays(),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      SizedBox(
                        width: (pageWidth - 52) / 2,
                        height: 212,
                        child: _getBestHabit(),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),
                    Text(
                      '진행중인 습관',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: gray500,
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      runSpacing: 8,
                      children: habits
                          .map((e) => _getActiveHabit(context, e))
                          .toList(),
                    ),
                  ],
                )
              ],
            ),
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
                Navigator.of(context).pushReplacementNamed('/habit/list');
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

  void _goToTopWithAnimation() {
    _controller.animateTo(
      0,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }

  /// 10월 박수
  Widget _getClapCount() {
    return Container(
      decoration: BoxDecoration(
        color: gray700,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          bottom: 24,
        ),
        child: Column(
          children: [
            Text(
              '10월 박수',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: gray300,
              ),
            ),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.front_hand,
                  size: 16,
                ),
                SizedBox(width: 12),
                Text('4'),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  /// 10월 습관 실천일
  Widget _getHabitDays() {
    return Container(
      decoration: BoxDecoration(
        color: gray700,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          bottom: 24,
        ),
        child: Column(
          children: [
            Text(
              '10월 습관 실천일',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: gray300,
              ),
            ),
            SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.front_hand,
                  size: 16,
                ),
                SizedBox(width: 12),
                Text('4'),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  /// 이번달, 가장 많이 실천한 습관
  Widget _getBestHabit() {
    return Container(
      decoration: BoxDecoration(
        color: green50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(height: 18),
          Text(
            '이번달,\n가장 많이 실천한 습관',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          SizedBox(height: 19),
          Icon(
            Icons.add,
            size: 48,
          ),
          SizedBox(height: 28),
          Text('text\ntext'),
          SizedBox(
            height: 17,
          ),
          Spacer(),
        ],
      ),
    );
  }

  /// 진행중인 습관
  Widget _getActiveHabit(BuildContext context, Habit habit) {
    return GestureDetector(
      onTapUp: (_) {
        // TODO: do something
        StatisticsDetailPage.route(context, habit.habitId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                '🍊',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(width: 8),
              Text(
                habit.title,
                style: TextStyle(
                  color: Color(0xFF353C49),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Icon(
                Icons.navigate_next_outlined,
                color: Color(0xFFC4CAD4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
