import 'package:flutter/material.dart';

import '../../domain/habit/notification/notification_repository.dart';
import '../../domain/habit/notification/three_days_notification.dart';

class NotificationListPage extends StatelessWidget {
  NotificationListPage({super.key});

  final notificationRepository = NotificationRepository();

  @override
  Widget build(BuildContext context) {
    final gray450 = Color(0xFFA5ADBD);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '알림',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<ThreeDaysNotification>>(
            future: notificationRepository.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Container();
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {}
                  if (snapshot.data!.isEmpty) {
                    return _getEmptyWidget(gray450);
                  }
                  return _getNotificationList(snapshot.data!);
              }
            }),
      ),
    );
  }

  Widget _getNotificationList(List<ThreeDaysNotification> notifications) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _getNotificationButton(notification);
        },
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }

  Widget _getNotificationButton(ThreeDaysNotification notification) {
    return GestureDetector(
      onTapUp: (details) async {
        if (notification.read) {
          // 이미 읽은 경우
          // TODO: 페이지 이동
        } else {
          // 안읽은경우
          await notificationRepository.read(notification.notificationId);
          // TODO: 페이지 이동
        }
      },
      child: Container(
            color: Color(0xFFF4F6F8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logo_dev,
                    size: 34,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.title),
                        SizedBox(height: 6),
                        Text(
                          notification.content,
                          maxLines: 2,
                        ),
                        SizedBox(height: 12),
                        Text(notification.notifiedAt.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _getEmptyWidget(Color gray450) {
    return Column(
      children: [
        Spacer(
          flex: 224,
        ),
        Center(
          child: Column(
            children: [
              // FIXME: icon 적용
              Icon(
                Icons.inbox,
                size: 28,
                color: gray450,
              ),
              SizedBox(height: 15),
              Text(
                '아직 새로운 알림이 없어요.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: gray450,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '(알림은 30일 후 자동으로 삭제됩니다.)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: gray450,
                ),
              )
            ],
          ),
        ),
        Spacer(
          flex: 358,
        ),
      ],
    );
  }
}
