import 'event.dart';

/// A small, deterministic set of sample events around "today" so the month view
/// has something to render in M0. Replaced by the local store in M1.
List<Event> buildMockEvents([DateTime? now]) {
  final today = now ?? DateTime.now();
  DateTime at(int dayOffset, int h, [int m = 0]) {
    final d = DateTime(today.year, today.month, today.day + dayOffset);
    return DateTime(d.year, d.month, d.day, h, m);
  }

  return [
    Event(id: 'e1', title: 'Standup', start: at(0, 9, 30), end: at(0, 9, 45), colorId: 0),
    Event(id: 'e2', title: 'Lunch with Sam', start: at(0, 13), end: at(0, 14), colorId: 5),
    Event(id: 'e3', title: 'Gym', start: at(0, 18, 30), end: at(0, 19, 30), colorId: 2),
    Event(id: 'e4', title: 'Dentist', start: at(1, 11), end: at(1, 11, 45), colorId: 4),
    Event(id: 'e5', title: 'Design review', start: at(2, 15), end: at(2, 16), colorId: 6),
    Event(
      id: 'e6',
      title: 'Trip to Rome',
      start: DateTime(today.year, today.month, today.day + 3),
      end: DateTime(today.year, today.month, today.day + 6),
      allDay: true,
      colorId: 1,
    ),
    Event(id: 'e7', title: 'Call with bank', start: at(-1, 10), end: at(-1, 10, 30), colorId: 7),
    Event(id: 'e8', title: 'Mum birthday', start: at(5, 0), end: at(6, 0), allDay: true, colorId: 5),
    Event(id: 'e9', title: 'Project deadline', start: at(8, 17), end: at(8, 18), colorId: 4),
    Event(id: 'e10', title: 'Coffee', start: at(0, 16), end: at(0, 16, 30), colorId: 3),
    Event(id: 'e11', title: 'Yoga', start: at(0, 7), end: at(0, 8), colorId: 1),
  ];
}
