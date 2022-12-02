import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:three_days/design/three_days_colors.dart';
import 'package:three_days/domain/goal/goal.dart';
import 'package:three_days/ui/development_page.dart';
import 'package:three_days/ui/goal/goal_add_page.dart';
import 'package:three_days/ui/goal/goal_edit_page.dart';
import 'package:three_days/ui/goal/goal_list_page.dart';
import 'package:three_days/ui/mypage/habit_archived_page.dart';
import 'package:three_days/ui/mypage/mypage_page.dart';
import 'package:three_days/ui/mypage/privacy_policy_page.dart';
import 'package:three_days/ui/mypage/service_policy_page.dart';
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
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: ThreeDaysColors.textBlack,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: ThreeDaysColors.textBlack,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedItemColor: Color.fromRGBO(0xB0, 0xB8, 0xC1, 1.0),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: const TextStyle(
            color: Color.fromRGBO(0x11, 0x11, 0x11, 1.0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          actionsPadding: const EdgeInsets.only(bottom: 25),
        ),
        fontFamily: 'Suit',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThreeDaysColors.primary,
            disabledBackgroundColor: const Color.fromRGBO(0xAC, 0xAC, 0xAC, 1.0),
            disabledForegroundColor: Colors.white,
            elevation: 0.0,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
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
            pageBuilder: (_, __, ___) => MypagePage(),
          );
        }
        if (settings.name == '/habit-archived') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => HabitArchivedPage(),
          );
        }
        if (settings.name == '/policy/service') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const ServicePolicyPage(),
          );
        }
        if (settings.name == '/policy/privacy') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const PrivacyPolicyPage(),
          );
        }
        if (settings.name == '/development') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => DevelopmentPage(),
          );
        }
        return MaterialPageRoute(builder: (_) => GoalListPage());
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      locale: const Locale('ko'),
    );
  }
}
