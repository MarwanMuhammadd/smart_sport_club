import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_state.dart';

class SportsCubit extends Cubit<SportsState> {
  SportsCubit() : super(SportsInitial());

  // Cache to store generated/updated sessions
  final Map<String, List<SessionModel>> _sessionsCache = {};

  /// Convert DateTime to cache key format (YYYY-MM-DD)
  String _getDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void loadSessionsForDay(DateTime date) {
    // Standardize the date to remove time components
    final day = DateTime(date.year, date.month, date.day);
    final key = _getDateKey(day);

    if (!_sessionsCache.containsKey(key)) {
      _sessionsCache[key] = getSessionsForDay(day);
    }

    emit(SportsSessionsLoaded(sessionsPerDay: Map.from(_sessionsCache)));
  }

  void confirmBooking(String sessionId, DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final key = _getDateKey(day);

    if (_sessionsCache.containsKey(key)) {
      final sessions = _sessionsCache[key]!;
      final index = sessions.indexWhere((s) => s.id == sessionId);

      if (index != -1) {
        final session = sessions[index];
        if (session.currentBookings < session.maxCapacity) {
          sessions[index] = SessionModel(
            id: session.id,
            title: session.title,
            startTime: session.startTime,
            endTime: session.endTime,
            maxCapacity: session.maxCapacity,
            currentBookings: session.currentBookings + 1,
          );

          _sessionsCache[key] = List.from(sessions);
          emit(SportsSessionsLoaded(sessionsPerDay: Map.from(_sessionsCache)));
        }
      }
    }
  }

  List<SessionModel> getSessionsForDate(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final key = _getDateKey(day);
    return _sessionsCache[key] ?? [];
  }
}
