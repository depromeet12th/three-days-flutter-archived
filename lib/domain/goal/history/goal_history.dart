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

  DateTime getCheckedDate() {
    return DateTime(_checkedAt!.year, _checkedAt!.month, _checkedAt!.day);
  }

  @Deprecated('user test')
  void setCheckedAt(DateTime checkedAt) {
    _checkedAt = checkedAt;
  }

  /// dateTime 의 0시 이상 24시 미만 동안에 기록되었는지
  bool isCheckedDateAt(DateTime dateTime) {
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return !_checkedAt!.isBefore(date) &&
        _checkedAt!.isBefore(date.add(const Duration(days: 1)));
  }

  void setId(int goalHistoryId) {
    if (this.goalHistoryId > 0) {
      return;
    }
    if (goalHistoryId < 0) {
      throw Error();
    }
    this.goalHistoryId = goalHistoryId;
  }

  @override
  String toString() {
    return 'GoalHistory{goalHistoryId: $goalHistoryId, goalId: $goalId, checkedAt: $_checkedAt}';
  }
}
