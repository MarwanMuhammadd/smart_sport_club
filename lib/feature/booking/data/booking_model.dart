import 'package:smart_sport_club/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';

class BookingModel {
  final String academyName;
  final CoachData coach;
  final DateTime date;
  final SessionModel session;

  BookingModel({
    required this.academyName,
    required this.coach,
    required this.date,
    required this.session,
  });
}
