import 'package:three_days/domain/habit/notification/three_days_notification.dart';

class NotificationRepository {
  /// 알림 내역 조회
  Future<List<ThreeDaysNotification>> findAll() async {
    return [
        ThreeDaysNotification(
          1,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          true,
          DateTime.now()
        ),
      ThreeDaysNotification(
          2,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          true,
          DateTime.now()
      ),
      ThreeDaysNotification(
          3,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          true,
          DateTime.now()
      ),
      ThreeDaysNotification(
          4,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          false,
          DateTime.now()
      ),
      ThreeDaysNotification(
          5,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          false,
          DateTime.now()
      ),
      ThreeDaysNotification(
          6,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          false,
          DateTime.now()
      ),
      ThreeDaysNotification(
          7,
          '짝궁 진화',
          '짝꿍이 2단계로 성장했어요! 성장한 짝꿍의 모습이 궁금하시다면 클릭!',
          false,
          DateTime.now()
      ),
    ];
  }

  /// 읽음처리
  Future<ThreeDaysNotification> read(int notificationId) async {
    // TODO: api 연동
    return ThreeDaysNotification(
      notificationId,
      'title',
      'content',
      false,
      DateTime.now(),
    );
  }
}
