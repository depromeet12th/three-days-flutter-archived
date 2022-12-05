// TODO: startDate, endDate 추가
class Habit {
  int habitId;
  String title;

  Habit({
    this.habitId = 0,
    required this.title,
  });

  /// index: 0,1,2 위젯 중에 몇번째 인덱스 위젯인지
  bool isChecked(int currentIndex, int focusedIndex, bool isCheckedAtToday) {
    if (focusedIndex > currentIndex) {
      return true;
    }
    if (focusedIndex == currentIndex) {
      return isCheckedAtToday;
    }
    // focusedIndex < currentIndex 는 아직 도래하지않은 짝! 이므로 무조건 false
    return false;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'title': title,
    };
    if (habitId > 0) {
      map['goalId'] = habitId;
    }
    return map;
  }

  static Habit fromJson(Map<String, dynamic> json) {
    return Habit(
      habitId: json['goalId'] as int,
      title: json['title'] as String,
    );
  }

  @override
  String toString() {
    return 'Habit{habitId: $habitId, title: $title}';
  }

  void update({
    required String title,
  }) {
    this.title = title;
  }

  void setId(int goalId) {
    if (this.habitId > 0) {
      return;
    }
    if (goalId < 0) {
      throw Error();
    }
    this.habitId = goalId;
  }
}
