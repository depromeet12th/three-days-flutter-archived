class Goal {
  final int goalId;
  final String title;
  final int days;
  /// 0,1,2 중에 오늘 몇번째 짝! 누를수 있는지
  int clapIndex;
  /// 오늘꺼 눌렀는지 아닌지
  bool clapChecked;

  Goal({
    required this.goalId,
    required this.title,
    required this.days,
    this.clapIndex = 0,
    this.clapChecked = false,
  });

  /// index: 0,1,2 위젯 중에 몇번째 인덱스 위젯인지
  bool isChecked(int index) {
    if (clapIndex > index) {
      return true;
    }
    if (clapIndex == index) {
      return clapChecked;
    }
    // clapIndex < index 는 아직 도래하지않은 짝! 이므로 무조건 false
    return false;
  }

  /// index: 0,1,2 위젯 중에 몇번째 인덱스 위젯인지
  bool isFocused(int index) {
    return clapIndex == index;
  }

  void setChecked() {
    clapChecked = true;
  }

  void setUnchecked() {
    clapChecked = false;
  }

  @override
  String toString() {
    return 'Goal{title: $title, days: $days, clapIndex: $clapIndex, clapChecked: $clapChecked}';
  }
}
