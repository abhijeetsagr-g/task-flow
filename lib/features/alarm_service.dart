import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> scheduleAlarm({
    required int uniqueId,
    required String time,
    required String title,
    required String body,
  }) async {
    final formatter = DateFormat("d MMMM ''yy h:mm a");
    final DateTime parsedTime = formatter.parse(time);

    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(
      parsedTime,
      tz.local,
    );

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'alarm_channel_id',
          'Alarm Notifications',
          channelDescription: 'Channel for Task Flow alarms',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('alarm_sound'),
          ticker: 'ticker',
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.zonedSchedule(
      uniqueId,
      title,
      body,
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      matchDateTimeComponents: null, // for repeating, set dayOfWeek/timeOfDay
    );
  }
}
