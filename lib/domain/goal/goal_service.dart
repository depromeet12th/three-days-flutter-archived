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
    final yesterday = today.subtract(const Duration(days: 1));
    final theDayBeforeYesterday = today.subtract(const Duration(days: 2));

    // TODO: goal.StartDate 부터 min(어제,endDate) 구간 중 가장 최근에 clap 받은날 구하기
    final claps = await _clapRepository.findByGoalId(goal.goalId);

    // history 조회 시작날짜
    // lastClap != null
    //  ? lastClap.createdAt.add(Duration(days: 1))
    //  : min(startDate, yesterday)
    final DateTime historyFromDate;
    if (claps.isNotEmpty) {
      // TODO: clap 시간 역순 정렬
      final lastClap = claps.first;
      historyFromDate = lastClap.getCreatedDate().add(const Duration(days: 1));
    } else {
      historyFromDate = yesterday;
    }

    // history 조회 종료날짜
    // endDate < yesterday ? endDate : yesterday
    final historyToDate = yesterday;

    // history 목록의 날짜만 뽑고, 시간 역순으로 정렬 및 몇개 연속인지 구하기
    // 어제x : 0
    // 어제o - 그제x : 1
    // 어제o - 그제o : 2
    final goalHistories =
        await _goalHistoryRepository.findByGoalId(goal.goalId);
    final bool hasYesterday =
        goalHistories.where((e) => e.isCheckedDateAt(yesterday)).isNotEmpty;
    if (hasYesterday == false) {
      // 어제 안했으면, 오늘 첫번째칸 눌러야함
      return 0;
    }
    final bool hasTheDayBeforeYesterday = goalHistories
        .where((e) => e.isCheckedDateAt(theDayBeforeYesterday))
        .isNotEmpty;
    if (hasTheDayBeforeYesterday == false) {
      // 어제 했고, 그저께 안했으면 두 번째 칸 눌러야함
      return 1;
    } else {
      // 어제 했고, 그저께도 했으면 세 번째 칸 눌러야함
      return 2;
    }
  }

  /// 오늘 할 일 완료
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
