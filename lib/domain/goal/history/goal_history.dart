/// 짝심할일 완료 이력
class GoalHistory {
  /// pk
  int goalHistoryId;

  /// goal 식별자
  final int goalId;

  /// 완료한 시간
  DateTime? _checkedAt;

  GoalHistory({
    this.goalHistoryId = 0,
    required this.goalId,
    DateTime? checkedAt,
  }) : _checkedAt = checkedAt {
    _checkedAt ??= DateTime.now();
  }

  static GoalHistory fromJson(Map<String, dynamic> json) {
    return GoalHistory(
      goalHistoryId: json['goalHistoryId'] as int,
      goalId: json['goalId'] as int,
      checkedAt: DateTime.parse(json['checkedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'goalId': goalId,
      'checkedAt': _checkedAt!.toIso8601String(),
    };
    if (goalHistoryId > 0) {
      map['goalHistoryId'] = goalHistoryId;
    }
    return map;
  }

  DateTime getCheckedAt() {
    return _checkedAt!;
  }

  bool isCheckedAtDate(DateTime date) {
    return !_checkedAt!.isBefore(date) &&
        _checkedAt!.isBefore(date.add(const Duration(days: 1)));
  }

  @override
  String toString() {
    return 'GoalHistory{goalHistoryId: $goalHistoryId, goalId: $goalId, checkedAt: $_checkedAt}';
  }
}
