import 'package:flutter/material.dart';
import 'package:three_days/goal/goal_add_page.dart';
import 'package:three_days/goal/goal_list_page.dart';
import 'package:three_days/mypage_page.dart';
import 'package:three_days/statistics_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color.fromRGBO(0x1A, 0x1F, 27, 1.0),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromRGBO(0x1A, 0x1F, 27, 1.0),
          unselectedItemColor: Color.fromRGBO(0xB0, 0xB8, 0xC1, 1.0),
        ),
        fontFamily: 'Suit',
      ),
      initialRoute: '/goal/list',
      routes: {
        '/goal/list': (context) => GoalListPage(),
        '/goal/add': (context) => GoalAddPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/mypage': (context) => const MypagePage(),
      },
    );
  }
}
