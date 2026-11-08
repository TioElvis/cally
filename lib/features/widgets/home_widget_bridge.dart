import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

/// Port for the home-screen widgets: publish data, receive taps. The real
/// `home_widget` plugin is isolated in [HomeWidgetAdapter] (mobile only); the
/// fake is used on Linux/dev/tests.
abstract class HomeWidgetBridge {
  Future<void> publish(Map<String, String> data);
  Stream<Uri?> taps();
  Future<Uri?> initialLaunch();
}

class FakeHomeWidgetBridge implements HomeWidgetBridge {
  Map<String, String> lastPublished = const {};

  @override
  Future<void> publish(Map<String, String> data) async => lastPublished = Map.of(data);

  @override
  Stream<Uri?> taps() => const Stream.empty();

  @override
  Future<Uri?> initialLaunch() async => null;
}

HomeWidgetBridge createHomeWidgetBridge() {
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    return HomeWidgetAdapter();
  }
  return FakeHomeWidgetBridge();
}

/// Real adapter. Writes data to the shared App Group (iOS) /
/// SharedPreferences (Android) and asks the widgets to reload.
class HomeWidgetAdapter implements HomeWidgetBridge {
  // Must match the App Group id in the iOS extension / Runner entitlements.
  static const appGroupId = 'group.com.cally.cally';
  static const iosWidgetName = 'CallyWidget';
  static const androidWidgetName = 'CallyWidgetProvider';

  bool _inited = false;

  Future<void> _init() async {
    if (_inited) return;
    await HomeWidget.setAppGroupId(appGroupId);
    _inited = true;
  }

  @override
  Future<void> publish(Map<String, String> data) async {
    await _init();
    for (final e in data.entries) {
      await HomeWidget.saveWidgetData<String>(e.key, e.value);
    }
    await HomeWidget.updateWidget(
      iOSName: iosWidgetName,
      androidName: androidWidgetName,
    );
  }

  @override
  Stream<Uri?> taps() => HomeWidget.widgetClicked;

  @override
  Future<Uri?> initialLaunch() => HomeWidget.initiallyLaunchedFromHomeWidget();
}
