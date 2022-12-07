class Mate {
  int mateId;

  Mate({
    this.mateId = 0,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'mateId': mateId,
    };
    if (mateId > 0) {
      map['mateId'] = mateId;
    }
    return map;
  }

  static Mate fromJson(Map<String, dynamic> json) {
    return Mate(
      mateId: json['mateId'] as int,
    );
  }

}
