import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/settings/domain/entities/app_settings.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.showFcmNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  final _fcm = FirebaseMessaging.instance;

  static const _channelId = 'giftory_channel';
  static const _channelName = '기념일 알림';

  Future<void> init() async {
    tz_data.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(const InitializationSettings(
      android: android,
      iOS: ios,
    ));

    FirebaseMessaging.onMessage.listen((message) {
      showFcmNotification(message);
    });
  }

  Future<void> requestPermission() async {
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<String?> getFcmToken() => _fcm.getToken();

  Future<void> showFcmNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _plugin.show(
      message.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleForAnniversary(
    Anniversary ann,
    AppSettings settings,
  ) async {
    await cancelForAnniversary(ann.id);

    final next = ann.nextOccurrence;
    final now = DateTime.now();
    final baseId = ann.id.hashCode.abs() % 10000 * 10;

    Future<void> schedule(int offset, int idSuffix, String title) async {
      final date = next.subtract(Duration(days: offset));
      if (date.isAfter(now)) {
        await _schedule(
          id: baseId + idSuffix,
          title: title,
          body: '${ann.title} ${offset == 0 ? '오늘' : 'D-$offset'}',
          scheduledDate: tz.TZDateTime.from(date, tz.local),
        );
      }
    }

    await schedule(7, 0, '${ann.title} 1주일 전!');
    if (settings.notifyMonthBefore) await schedule(30, 1, '${ann.title} 한 달 전!');
    if (settings.notifyTwoWeeksBefore) await schedule(14, 2, '${ann.title} 2주 전!');
    if (settings.notifyDayBefore) await schedule(1, 3, '${ann.title} 하루 전!');
    if (settings.notifyOnDay) await schedule(0, 4, '${ann.title} 기념일!');
  }

  Future<void> cancelForAnniversary(String id) async {
    final baseId = id.hashCode.abs() % 10000 * 10;
    for (int i = 0; i <= 4; i++) {
      await _plugin.cancel(baseId + i);
    }
  }

  Future<void> rescheduleAll(
    List<Anniversary> anniversaries,
    AppSettings settings,
  ) async {
    await _plugin.cancelAll();
    for (final ann in anniversaries) {
      await scheduleForAnniversary(ann, settings);
    }
  }

  Future<void> _schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
