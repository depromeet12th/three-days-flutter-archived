/// 짝심할일 완료 이력
class HabitHistory {
  /// pk
  int habitHistoryId;

  /// goal 식별자
  final int habitId;

  /// 완료한 시간
  DateTime? _checkedAt;

  HabitHistory({
    this.habitHistoryId = 0,
    required this.habitId,
    DateTime? checkedAt,
  }) : _checkedAt = checkedAt {
    _checkedAt ??= DateTime.now();
  }

  static HabitHistory fromJson(Map<String, dynamic> json) {
    return HabitHistory(
      habitHistoryId: json['goalHistoryId'] as int,
      habitId: json['goalId'] as int,
      checkedAt: DateTime.parse(json['checkedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'goalId': habitId,
      'checkedAt': _checkedAt!.toIso8601String(),
    };
    if (habitHistoryId > 0) {
      map['goalHistoryId'] = habitHistoryId;
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

  void setId(int habitHistoryId) {
    if (this.habitHistoryId > 0) {
      return;
    }
    if (habitHistoryId < 0) {
      throw Error();
    }
    this.habitHistoryId = habitHistoryId;
  }

  @override
  String toString() {
    return 'HabitHistory{habitHistoryId: $habitHistoryId, habitId: $habitId, checkedAt: $_checkedAt}';
  }
}
