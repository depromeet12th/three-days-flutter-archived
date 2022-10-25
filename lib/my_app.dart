import 'package:flutter/material.dart';
import 'package:three_days/design/three_days_colors.dart';
import 'package:three_days/domain/goal/goal.dart';
import 'package:three_days/ui/goal/goal_add_page.dart';
import 'package:three_days/ui/goal/goal_edit_page.dart';
import 'package:three_days/ui/goal/goal_list_page.dart';
import 'package:three_days/ui/mypage_page.dart';
import 'package:three_days/ui/statistics_page.dart';

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
            color: ThreeDaysColors.textBlack,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: ThreeDaysColors.textBlack,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
          unselectedItemColor: Color.fromRGBO(0xB0, 0xB8, 0xC1, 1.0),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(0x11, 0x11, 0x11, 1.0),
            fontSize: 20,
          ),
          contentTextStyle: const TextStyle(
            color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
            fontSize: 15,
          ),
          actionsPadding: const EdgeInsets.only(bottom: 20),
        ),
        fontFamily: 'Suit',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThreeDaysColors.primary,
            disabledBackgroundColor: const Color.fromRGBO(0xAC, 0xAC, 0xAC, 1.0),
            disabledForegroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
      ),
      initialRoute: '/goal/list',
      onGenerateRoute: (settings) {
        if (settings.name == '/goal/list') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => GoalListPage(),
          );
        }
        if (settings.name == '/goal/add') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => GoalAddPage(),
          );
        }
        if (settings.name == '/goal/edit') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) =>
                GoalEditPage(goal: settings.arguments as Goal),
          );
        }
        if (settings.name == '/statistics') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const StatisticsPage(),
          );
        }
        if (settings.name == '/mypage') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const MypagePage(),
          );
        }
        return MaterialPageRoute(builder: (_) => GoalListPage());
      },
    );
  }
}
