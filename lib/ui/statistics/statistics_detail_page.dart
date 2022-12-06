import 'package:flutter/material.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/ui/statistics/statistics_detail_page_arguments.dart';
import 'package:three_days/ui/statistics/three_days_calendar.dart';

class StatisticsDetailPage extends StatelessWidget {
  StatisticsDetailPage({super.key});

  static const routeName = '/statistics/habits';

  static void route(BuildContext context, int habitId) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: StatisticsDetailPageArguments(habitId: habitId),
    );
  }

  // TODO: DI
  final HabitRepository habitRepository = HabitRepository();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as StatisticsDetailPageArguments;
    final habitId = arguments.habitId;
    return SafeArea(
      child: Scaffold(
        appBar:
            PreferredSize(preferredSize: Size.fromHeight(73), child: AppBar()),
        body: FutureBuilder(
          future: habitRepository.findById(habitId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Text('loading');
            }
            if (snapshot.hasError) {
              return Text('error');
            }
            final habit = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _getHabitDetail(habit),
                  SizedBox(height: 32),
                  _getHabitCalendar(habit),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getHabitDetail(Habit habit) {
    return Column(
      children: [
        SizedBox(height: 12),
        Text(habit.title),
        SizedBox(height: 14),
        Row(
          children: [
            Text('42일째'),
            SizedBox(width: 8),
            Text('월,화,수'),
          ],
        ),
        SizedBox(height: 12),
        Text('시작일: 2022. 08. 15.'),
        SizedBox(height: 32),
        Row(
          children: [
            Text('박수'),
            Text('습관 실천일'),
          ],
        ),
      ],
    );
  }

  Widget _getHabitCalendar(Habit habit) {
    return ThreeDaysCalendar(yearMonth: DateTime.now());
  }
}
