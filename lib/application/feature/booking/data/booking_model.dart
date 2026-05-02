import 'package:smart_sport_club/core/models/trainer_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/slots_data.dart';

class BookingModel {
  final String academyName;
  final TrainerModel coach;
  final DateTime date;
  final SessionModel session;

  BookingModel({
    required this.academyName,
    required this.coach,
    required this.date,
    required this.session,
  });
}
