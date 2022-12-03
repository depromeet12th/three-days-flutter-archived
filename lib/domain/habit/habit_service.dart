import 'package:flutter/foundation.dart';
import 'package:three_days/domain/habit/clap/clap.dart';
import 'package:three_days/domain/habit/clap/clap_repository.dart';
import 'package:three_days/domain/habit/habit.dart';
import 'package:three_days/domain/habit/habit_repository.dart';
import 'package:three_days/domain/habit/history/habit_history.dart';
import 'package:three_days/domain/habit/history/habit_history_repository.dart';

class HabitService {
  // TODO: DI
  final HabitRepository _habitRepository = HabitRepository();
  final HabitHistoryRepository _habitHistoryRepository = HabitHistoryRepository();
  final ClapRepository _clapRepository = ClapRepository();

  /// 삭제된 습관 목록 조회
  Future<List<Habit>> getArchivedHabits() async {
    // TODO: api 연동 필요. query parameter status 로 조회
    return [];
  }

  Future<Habit> create(String title) async {
    final habit = Habit(
      title: title,
    );
    return await _habitRepository.save(habit);
  }

  Future<Habit> createForContinuousDays(String title, int days) async {
    final habit = await _habitRepository.save(Habit(
      title: title,
    ));

    int count = 0;
    for (int i = days; i > 0; i--) {
      final history = HabitHistory(habitId: habit.habitId);
      history.setCheckedAt(DateTime.now().subtract(Duration(days: i)));
      await _habitHistoryRepository.save(history);

      if (++count % 3 == 0) {
        final clap = Clap(habitId: history.habitId, habitHistoryId: history.habitHistoryId);
        clap.setCreatedAt(DateTime.now().subtract(const Duration(days: 1)));
        await _clapRepository.save(clap);
      }
    }

    return habit;
  }

  /// 성공한 이력 개수
  Future<int> countHistories(int habitId) async {
    final count = (await _habitHistoryRepository.findByHabitId(habitId))
        .map((e) => e.getCheckedDate())
        .toSet()
        .length;
    if (kDebugMode) {
      print('HabitService.countHistories habitId: $habitId, count: $count');
    }
    return count;
  }

  /// 오늘 완료되었는지 여부
  Future<bool> isCheckedDateAt(int habitId, DateTime dateTime) async {
    final hasCheckedAtToday =
        (await _habitHistoryRepository.findByHabitId(habitId))
            .where((e) => e.isCheckedDateAt(dateTime))
            .isNotEmpty;
    if (kDebugMode) {
      print(
          'HabitService.isCheckedDateAt habitId: $habitId, dateTime: $dateTime, hasCheckedAtToday: $hasCheckedAtToday');
    }
    return hasCheckedAtToday;
  }

  /// 오늘 체크할 칸이 몇번째인지 계산
  Future<int> calculateClapIndex(Habit habit, DateTime now) async {
    final today = DateTime(now.year, now.month, now.day);
    final habitHistories =
        await _habitHistoryRepository.findByHabitId(habit.habitId);

    // 어제부터 하루씩 과거로 거슬러가면서 연속인지 아닌지 구한다.
    // 연속이면 계속 하고
    // 안한날이면 거기까지 며칠이었는지 리턴
    int days = 0;
    while (true) {
      final bool hasDay =
          habitHistories.where((e) => e.isCheckedDateAt(today.subtract(Duration(days: days + 1)))).isNotEmpty;
      if (hasDay == false) {
        return days % 3;
      }
      days++;
    }
  }

  /// 오늘 할 일 완료;
  Future<Clap?> check(Habit habit) async {
    // goalHistory 생성
    final habitHistory = HabitHistory(
      habitId: habit.habitId,
    );
    await _habitHistoryRepository.save(habitHistory);

    // 3일차 짝이면, clap 생성
    DateTime now = DateTime.now();
    final index = await calculateClapIndex(habit, now);
    if (kDebugMode) {
      print('index: $index');
    }
    // 3일차가 아닌 경우 아무것도 안함
    if (index != 2) {
      return null;
    }
    final clapsCreatedAtToday = (await _clapRepository.findByHabitId(habit.habitId))
        .where((e) => e.isCreatedDateAt(now));
    // 이미 오늘 생성한 박수가 있는 경우
    if (clapsCreatedAtToday.isNotEmpty) {
      return clapsCreatedAtToday.first;
    }
    // 오늘 처음 박수를 생성하는 경우
    final clap = Clap(
      habitId: habit.habitId,
      habitHistoryId: habitHistory.habitHistoryId,
    );
    return await _clapRepository.save(clap);
  }

  /// 오늘 한 일 취소
  Future<void> uncheck(Habit habit) async {
    if (kDebugMode) {
      print('HabitService.uncheck habit: $habit');
    }

    // 오늘 날짜의 goalHistory 있다면 삭제
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final habitHistories =
        await _habitHistoryRepository.findByHabitId(habit.habitId);
    habitHistories.where((e) {
      // [오늘0시:내일0시)
      return !e.getCheckedAt().isBefore(today) &&
          e.getCheckedAt().isBefore(tomorrow);
    }).forEach((habitHistory) async {
      if (kDebugMode) {
        print('HabitService.uncheck habitHistory: $habitHistory');
      }
      await _habitHistoryRepository.delete(habitHistory.habitHistoryId);
    });
  }

  Future<void> delete(int habitId) async {
    if (kDebugMode) {
      print('HabitService.delete habitId: $habitId');
    }
    await _habitRepository.deleteById(habitId);
    await _habitHistoryRepository.deleteByHabitId(habitId);
  }
}
