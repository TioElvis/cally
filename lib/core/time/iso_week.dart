/// ISO-8601 week number (1–53) for [date]. Weeks start on Monday; week 1 is the
/// week containing the year's first Thursday (equivalently, the week of Jan 4).
/// Pure and testable.
int isoWeekNumber(DateTime date) {
  final thursday = _thursdayOfWeek(DateTime.utc(date.year, date.month, date.day));
  // Jan 4 is always in ISO week 1, in the Thursday's ISO-week-year.
  final week1Thursday = _thursdayOfWeek(DateTime.utc(thursday.year, 1, 4));
  return 1 + (thursday.difference(week1Thursday).inDays ~/ 7);
}

/// The Thursday of the ISO week that [d] belongs to.
DateTime _thursdayOfWeek(DateTime d) {
  final mondayIndex = (d.weekday + 6) % 7; // Mon=0 .. Sun=6
  return d.add(Duration(days: 3 - mondayIndex));
}
