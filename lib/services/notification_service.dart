import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:timezone/data/latest.dart' as timezone;

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationPlugin =
  FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  init() {
    AndroidInitializationSettings initializationAndroidSettings =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationAndroidSettings,
    );
    _localNotificationPlugin.initialize(initializationSettings);
  }

  void sendInstanceNotification({
    required String title,
    required String description,
  }) {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "instant_channel",
        "instant_notification",
        channelDescription: "Notification that appears instantly..!",
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    _localNotificationPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      description,
      notificationDetails,
    );
  }

  void sendScheduleNotification({

    required String title,
    required String body,
    required DateTime dateTime,

  })
  {
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "scheduled_channel",
        "scheduled_notification",
        channelDescription: "Notification that appears instantly..!",
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    _localNotificationPlugin.zonedSchedule(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title, body,
        timezone.TZDateTime.from(dateTime,timezone.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);



  }
}