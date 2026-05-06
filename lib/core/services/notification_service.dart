import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static const int dailyExpenseReminderId = 1001;

  static const String dailyTitle = "Is today's report ready? 📝";
  static const String dailyBody = "How was your day? Don’t forget to record all of today’s expenses.";

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings: initSettings);
    await requestPermission();
  }

  static Future<void> requestPermission() async {
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showTestNotification() async {
    await _plugin.show(
      id: 9999,
      title: dailyTitle,
      body: dailyBody,
      notificationDetails: _details(),
    );
  }

  static Future<void> scheduleDailyExpenseReminder({int hour = 21, int minute = 0}) async {
    await _plugin.zonedSchedule(
      id: dailyExpenseReminderId,
      title: dailyTitle,
      body: dailyBody,
      scheduledDate: _nextInstanceOfTime(hour, minute),
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelDailyExpenseReminder() async {
    await _plugin.cancel(id: dailyExpenseReminderId);
  }

  static Future<void> scheduleTestInSeconds({int seconds = 30}) async {
    await _plugin.zonedSchedule(
      id: 1002,
      title: 'Test scheduled notification',
      body: 'This message was scheduled ${seconds}s ago.',
      scheduledDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static NotificationDetails _details() {
    const android = AndroidNotificationDetails(
      'daily_expense_reminder_channel',
      'Daily Expense Reminder',
      channelDescription: 'Daily reminder to record today expenses',
      importance: Importance.max,
      priority: Priority.high,
    );
    return const NotificationDetails(android: android);
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
