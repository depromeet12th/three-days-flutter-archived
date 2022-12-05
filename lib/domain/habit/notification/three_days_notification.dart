/// 눌렀을 때 어디 페이지로 가야되는지 어떻게 알지?
class ThreeDaysNotification {
  int notificationId;
  String title;
  String content;
  bool read;
  DateTime notifiedAt;

  ThreeDaysNotification(this.notificationId, this.title, this.content,
      this.read, this.notifiedAt);
}
