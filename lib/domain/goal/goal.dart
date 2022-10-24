// TODO: startDate, endDate 추가
class Goal {
  int goalId;
  String title;
  final int days;

  /// 0,1,2 중에 오늘 몇번째 짝! 누를수 있는지
  int clapIndex;

  /// 오늘꺼 눌렀는지 아닌지
  bool clapChecked;

  Goal({
    this.goalId = 0,
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

  Map<String, dynamic> toMap() {
    final map = {
      'title': title,
      'days': days,
      'clapIndex': clapIndex,
      'clapChecked': clapChecked ? 1 : 0,
    };
    if (goalId > 0) {
      map['goalId'] = goalId;
    }
    return map;
  }

  static Goal fromJson(Map<String, dynamic> json) {
    return Goal(
      goalId: json['goalId'] as int,
      title: json['title'] as String,
      days: json['days'] as int,
      clapIndex: json['clapIndex'] as int,
      clapChecked: json['clapChecked'] == 1 ? true : false,
    );
  }

  @override
  String toString() {
    return 'Goal{goalId: $goalId, title: $title, days: $days, clapIndex: $clapIndex, clapChecked: $clapChecked}';
  }

  void update({
    required String title,
  }) {
    this.title = title;
  }

  void setId(int goalId) {
    if (this.goalId > 0) {
      return;
    }
    if (goalId < 0) {
      throw Error();
    }
    this.goalId = goalId;
  }
}
