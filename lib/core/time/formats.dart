import 'package:intl/intl.dart';

/// Time-of-day formatter honouring the 24-hour setting.
DateFormat timeFmt(bool use24h) => DateFormat(use24h ? 'HH:mm' : 'h:mm a');

String fmtTime(DateTime d, bool use24h) => timeFmt(use24h).format(d);

/// "Weekday d Month, time" for event rows / editor.
String fmtDateTime(DateTime d, bool use24h) =>
    '${DateFormat('EEE d MMM').format(d)}, ${fmtTime(d, use24h)}';

String fmtDate(DateTime d) => DateFormat('EEE d MMM y').format(d);
