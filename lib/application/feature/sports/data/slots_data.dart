class SessionModel {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int maxCapacity;
  final int currentBookings;

  SessionModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.maxCapacity = 20,
    this.currentBookings = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          maxCapacity == other.maxCapacity &&
          currentBookings == other.currentBookings;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      maxCapacity.hashCode ^
      currentBookings.hashCode;
}

DateTime today = DateTime.now();

List<SessionModel> getSessionsForDay(DateTime date) {
  int dayOffset = date.difference(today).inDays;
  int numSlots = 3 + dayOffset; // كل يوم عدد slots مختلف

  return List.generate(numSlots, (i) {
    // For testing: make the second slot of today full (20/20)
    int initialBookings = (i == 1 && dayOffset == 0) ? 20 : (i * 5) % 20;

    return SessionModel(
      id: "session_${date.year}_${date.month}_${date.day}_${i + 1}",
      title: "Session ${i + 1}",
      startTime: DateTime(date.year, date.month, date.day, 9 + i, 0),
      endTime: DateTime(date.year, date.month, date.day, 10 + i, 0),
      currentBookings: initialBookings,
    );
  });
}
