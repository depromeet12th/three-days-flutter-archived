// TODO 사용, 미사용 여부 추가 필요
/// 연속 3일 목표 이뤄서 받은 박수
class Clap {
  /// PK
  int clapId;

  /// goal 식별자
  final int goalId;

  /// goal history 식별자
  final int goalHistoryId;

  /// 생성시각
  DateTime? _createdAt;

  Clap({
    this.clapId = 0,
    required this.goalId,
    required this.goalHistoryId,
    DateTime? createdAt,
  }) : _createdAt = createdAt {
    _createdAt ??= DateTime.now();
  }

  static Clap fromJson(Map<String, dynamic> json) {
    return Clap(
      clapId: json['clapId'] as int,
      goalId: json['goalId'] as int,
      goalHistoryId: json['goalHistoryId'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'goalId': goalId,
      'goalHistoryId': goalHistoryId,
      'createdAt': _createdAt!.toIso8601String(),
    };
    if (clapId > 0) {
      map['clapId'] = clapId;
    }
    return map;
  }

  DateTime getCreatedDate() {
    return DateTime(_createdAt!.year, _createdAt!.month, _createdAt!.day);
  }

  bool isCreatedDateAt(DateTime dateTime) {
    DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime createdDate = getCreatedDate();
    return createdDate.isAtSameMomentAs(date);
  }

  void setId(int clapId) {
    if (this.clapId > 0) {
      return;
    }
    if (clapId < 0) {
      throw Error();
    }
    this.clapId = clapId;
  }

  @override
  String toString() {
    return 'Clap{clapId: $clapId, goalId: $goalId, goalHistoryId: $goalHistoryId, _createdAt: $_createdAt}';
  }
}
