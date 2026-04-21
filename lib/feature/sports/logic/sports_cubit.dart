import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/notification/data/notification_model.dart';
import 'package:smart_sport_club/feature/notification/logic/notification_cubit.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_state.dart';

class SportsCubit extends Cubit<SportsState> {
  final NotificationCubit notificationCubit;

  SportsCubit(this.notificationCubit) : super(SportsInitial());

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

  void confirmBooking(BookingModel booking) {
    final day = DateTime(booking.date.year, booking.date.month, booking.date.day);
    final key = _getDateKey(day);

    if (_sessionsCache.containsKey(key)) {
      final sessions = _sessionsCache[key]!;
      final index = sessions.indexWhere((s) => s.id == booking.session.id);

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

          // Determine color and icon based on sport
          final color = _getSportColor(booking.academyName);
          final icon = _getSportIcon(booking.academyName);

          // TRIGGER NOTIFICATION
          notificationCubit.addNotification(
            NotificationModel(
              title: "Booking Confirmed!",
              description:
                  "Your booking for '${session.title}' at ${booking.academyName} is confirmed.",
              time: DateTime.now(),
              icon: icon,
              color: color,
              extraData: booking, // Store the model for navigation
            ),
          );
        }
      }
    }
  }

  Color _getSportColor(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('swim')) return AppColors.lightBlue;
    if (lowerName.contains('tennis')) return Colors.orange;
    return AppColors.primaryGreen; // Default for Football/others
  }

  IconData _getSportIcon(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('swim')) return Icons.pool;
    if (lowerName.contains('tennis')) return Icons.sports_tennis;
    if (lowerName.contains('football')) return Icons.sports_soccer;
    return Icons.check_circle_outline;
  }

  List<SessionModel> getSessionsForDate(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final key = _getDateKey(day);
    return _sessionsCache[key] ?? [];
  }
}
