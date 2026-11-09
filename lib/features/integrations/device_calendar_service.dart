import '../../data/event_repository.dart';

/// A calendar on the device (iOS EventKit / Android CalendarContract).
class DeviceCal {
  final String id;
  final String name;
  const DeviceCal(this.id, this.name);
}

/// Reads the device's calendars/events so they can be imported into Cally's
/// local store (additive — the local store stays the source of truth).
///
/// **Blocked:** the `device_calendar` plugin (3.9.x) still declares the removed
/// `jcenter()` repository and fails the current Android Gradle build; 4.x
/// conflicts with our `timezone` version (needed by flutter_local_notifications).
/// So only the fake is wired for now. The real adapter lands once a
/// device_calendar release supports current Gradle *and* timezone 0.11 — or we
/// fork it / write a thin platform channel. See docs/INTEGRATIONS.md. This port
/// keeps the rest of the app ready for that swap.
abstract class DeviceCalendarService {
  /// Whether a real device-calendar backend is available on this build.
  bool get available;
  Future<bool> ensurePermission();
  Future<List<DeviceCal>> calendars();

  /// Import device events in [from, to) from [deviceCalendarId] into the local
  /// [targetCalendarId]. Returns how many were imported.
  Future<int> importInto(
    EventRepository repo, {
    required String deviceCalendarId,
    required String targetCalendarId,
    required DateTime from,
    required DateTime to,
  });
}

class FakeDeviceCalendarService implements DeviceCalendarService {
  @override
  bool get available => false;
  @override
  Future<bool> ensurePermission() async => false;
  @override
  Future<List<DeviceCal>> calendars() async => const [];
  @override
  Future<int> importInto(EventRepository repo,
          {required String deviceCalendarId,
          required String targetCalendarId,
          required DateTime from,
          required DateTime to}) async =>
      0;
}

DeviceCalendarService createDeviceCalendarService() => FakeDeviceCalendarService();
