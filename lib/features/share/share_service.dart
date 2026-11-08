import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

/// Port for the OS share sheet. Isolated so the UI is testable with the fake.
abstract class ShareService {
  Future<void> shareText(String text, {String? subject});
  Future<void> shareIcs(String ics, String filename, {String? subject});
}

class FakeShareService implements ShareService {
  String? lastText;
  String? lastIcs;

  @override
  Future<void> shareText(String text, {String? subject}) async => lastText = text;

  @override
  Future<void> shareIcs(String ics, String filename, {String? subject}) async =>
      lastIcs = ics;
}

/// Real adapter over share_plus (works on iOS/Android and desktop).
class SharePlusAdapter implements ShareService {
  @override
  Future<void> shareText(String text, {String? subject}) =>
      SharePlus.instance.share(ShareParams(text: text, subject: subject));

  @override
  Future<void> shareIcs(String ics, String filename, {String? subject}) {
    final file = XFile.fromData(
      Uint8List.fromList(ics.codeUnits),
      mimeType: 'text/calendar',
      name: filename,
    );
    return SharePlus.instance.share(ShareParams(files: [file], subject: subject));
  }
}
