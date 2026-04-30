import 'package:equatable/equatable.dart';
import 'package:smart_sport_club/application/feature/sports/data/slots_data.dart';

abstract class SportsState extends Equatable {
  const SportsState();
  @override
  List<Object?> get props => [];
}

class SportsInitial extends SportsState {}

class SportsSessionsLoaded extends SportsState {
  final Map<String, List<SessionModel>> sessionsPerDay;

  const SportsSessionsLoaded({required this.sessionsPerDay});

  @override
  List<Object?> get props => [sessionsPerDay];
}
