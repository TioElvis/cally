import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'notification_plan.dart';

/// Port for local notifications + app badge. The UI/scheduler only ever talk to
/// this; the real plugin is isolated in [LocalNotificationService] and only used
/// on iOS/Android. Everywhere else (Linux dev, tests) the fake is used.
abstract class NotificationService {
  Future<bool> requestPermission();
  Future<void> replaceAll(List<PlannedNotification> planned);
  Future<void> setBadge(int count);
  Future<void> cancelAll();
}

/// Records what would be scheduled, so logic can be exercised without a device.
class FakeNotificationService implements NotificationService {
  List<PlannedNotification> scheduled = const [];
  int badge = 0;
  bool granted = true;

  @override
  Future<bool> requestPermission() async => granted;

  @override
  Future<void> replaceAll(List<PlannedNotification> planned) async =>
      scheduled = List.of(planned);

  @override
  Future<void> setBadge(int count) async => badge = count;

  @override
  Future<void> cancelAll() async => scheduled = const [];
}

/// Pick the real service on mobile, the fake elsewhere.
NotificationService createNotificationService() {
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    return LocalNotificationService();
  }
  return FakeNotificationService();
}

/// Real adapter over flutter_local_notifications. Scaffolded here; final device
/// verification (permissions, exact-alarm manifest, tz) happens on the Mac/device.
class LocalNotificationService implements NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _inited = false;

  Future<void> _init() async {
    if (_inited) return;
    tzdata.initializeTimeZones();
    // Set the device's timezone so zonedSchedule fires at the right local time
    // (and stays correct across DST).
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      // Fall back to UTC if the platform can't report a timezone.
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
        settings: const InitializationSettings(android: android, iOS: darwin));
    _inited = true;
  }

  @override
  Future<bool> requestPermission() async {
    await _init();
    if (Platform.isIOS) {
      final r = await _plugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return r ?? false;
    }
    final r = await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return r ?? false;
  }

  @override
  Future<void> replaceAll(List<PlannedNotification> planned) async {
    await _init();
    await _plugin.cancelAll();
    const details = NotificationDetails(
      android: AndroidNotificationDetails('cally.events', 'Events',
          importance: Importance.high, priority: Priority.high),
      iOS: DarwinNotificationDetails(),
    );
    for (final p in planned) {
      await _plugin.zonedSchedule(
        id: p.key.hashCode & 0x7fffffff,
        title: p.title,
        body: p.body,
        scheduledDate: tz.TZDateTime.from(p.when, tz.local),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  @override
  Future<void> setBadge(int count) async {
    // Setting the app-icon badge directly needs a platform badge API; wired on
    // device (TODO). No-op here so the rest of M3 works.
  }

  @override
  Future<void> cancelAll() async {
    await _init();
    await _plugin.cancelAll();
  }
}
