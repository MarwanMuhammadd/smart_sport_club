class SessionModel {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  SessionModel({
    required this.title,
    required this.startTime,
    required this.endTime,
  });
}

DateTime today = DateTime.now();

List<SessionModel> getSessionsForDay(DateTime date) {
  int dayOffset = date.difference(today).inDays;
  int numSlots = 3 + dayOffset; // كل يوم عدد slots مختلف

  return List.generate(numSlots, (i) {
    return SessionModel(
      title: "Session ${i+1}",
      startTime: DateTime(date.year, date.month, date.day, 9 + i, 0),
      endTime: DateTime(date.year, date.month, date.day, 10 + i, 0),
    );
  });
}