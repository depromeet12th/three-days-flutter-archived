import 'package:flutter/foundation.dart';
import 'package:three_days/domain/goal/clap/clap.dart';
import 'package:three_days/domain/goal/clap/clap_repository.dart';
import 'package:three_days/domain/goal/goal.dart';
import 'package:three_days/domain/goal/goal_repository.dart';
import 'package:three_days/domain/goal/history/goal_history.dart';
import 'package:three_days/domain/goal/history/goal_history_repository.dart';

class GoalService {
  // TODO: DI
  final GoalRepository _goalRepository = GoalRepository();
  final GoalHistoryRepository _goalHistoryRepository = GoalHistoryRepository();
  final ClapRepository _clapRepository = ClapRepository();

  Future<Goal> create(String title) async {
    final goal = Goal(
      title: title,
    );
    return await _goalRepository.save(goal);
  }

  Future<Goal> createForContinuousDays(String title, int days) async {
    final goal = await _goalRepository.save(Goal(
      title: title,
    ));

    int count = 0;
    for (int i = days; i > 0; i--) {
      final history = GoalHistory(goalId: goal.goalId);
      history.setCheckedAt(DateTime.now().subtract(Duration(days: i)));
      await _goalHistoryRepository.save(history);

      if (++count % 3 == 0) {
        final clap = Clap(goalId: history.goalId, goalHistoryId: history.goalHistoryId);
        clap.setCreatedAt(DateTime.now().subtract(const Duration(days: 1)));
        await _clapRepository.save(clap);
      }
    }

    return goal;
  }

  /// 성공한 이력 개수
  Future<int> countHistories(int goalId) async {
    final count = (await _goalHistoryRepository.findByGoalId(goalId))
        .map((e) => e.getCheckedDate())
        .toSet()
        .length;
    if (kDebugMode) {
      print('GoalService.countHistories goalId: $goalId, count: $count');
    }
    return count;
  }

  /// 오늘 완료되었는지 여부
  Future<bool> isCheckedDateAt(int goalId, DateTime dateTime) async {
    final hasCheckedAtToday =
        (await _goalHistoryRepository.findByGoalId(goalId))
            .where((e) => e.isCheckedDateAt(dateTime))
            .isNotEmpty;
    if (kDebugMode) {
      print(
          'GoalService.isCheckedDateAt goalId: $goalId, dateTime: $dateTime, hasCheckedAtToday: $hasCheckedAtToday');
    }
    return hasCheckedAtToday;
  }

  /// 오늘 체크할 칸이 몇번째인지 계산
  Future<int> calculateClapIndex(Goal goal, DateTime now) async {
    final today = DateTime(now.year, now.month, now.day);
    final goalHistories =
        await _goalHistoryRepository.findByGoalId(goal.goalId);

    // 어제부터 하루씩 과거로 거슬러가면서 연속인지 아닌지 구한다.
    // 연속이면 계속 하고
    // 안한날이면 거기까지 며칠이었는지 리턴
    int days = 0;
    while (true) {
      final bool hasDay =
          goalHistories.where((e) => e.isCheckedDateAt(today.subtract(Duration(days: days + 1)))).isNotEmpty;
      if (hasDay == false) {
        return days % 3;
      }
      days++;
    }
  }

  /// 오늘 할 일 완료;
  Future<Clap?> check(Goal goal) async {
    // goalHistory 생성
    final goalHistory = GoalHistory(
      goalId: goal.goalId,
    );
    await _goalHistoryRepository.save(goalHistory);

    // 3일차 짝이면, clap 생성
    DateTime now = DateTime.now();
    final index = await calculateClapIndex(goal, now);
    if (kDebugMode) {
      print('index: $index');
    }
    // 3일차가 아닌 경우 아무것도 안함
    if (index != 2) {
      return null;
    }
    final clapsCreatedAtToday = (await _clapRepository.findByGoalId(goal.goalId))
        .where((e) => e.isCreatedDateAt(now));
    // 이미 오늘 생성한 박수가 있는 경우
    if (clapsCreatedAtToday.isNotEmpty) {
      return clapsCreatedAtToday.first;
    }
    // 오늘 처음 박수를 생성하는 경우
    final clap = Clap(
      goalId: goal.goalId,
      goalHistoryId: goalHistory.goalHistoryId,
    );
    return await _clapRepository.save(clap);
  }

  /// 오늘 한 일 취소
  Future<void> uncheck(Goal goal) async {
    if (kDebugMode) {
      print('GoalService.uncheck goal: $goal');
    }

    // 오늘 날짜의 goalHistory 있다면 삭제
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final goalHistories =
        await _goalHistoryRepository.findByGoalId(goal.goalId);
    goalHistories.where((e) {
      // [오늘0시:내일0시)
      return !e.getCheckedAt().isBefore(today) &&
          e.getCheckedAt().isBefore(tomorrow);
    }).forEach((goalHistory) async {
      if (kDebugMode) {
        print('GoalService.uncheck goalHistory: $goalHistory');
      }
      await _goalHistoryRepository.delete(goalHistory.goalHistoryId);
    });
  }

  Future<void> delete(int goalId) async {
    if (kDebugMode) {
      print('GoalService.delete goalId: $goalId');
    }
    await _goalRepository.deleteById(goalId);
    await _goalHistoryRepository.deleteByGoalId(goalId);
  }
}
