import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'device_calendar_service.dart';

final deviceCalendarServiceProvider =
    Provider<DeviceCalendarService>((_) => createDeviceCalendarService());
