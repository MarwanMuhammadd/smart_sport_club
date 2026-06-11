import 'package:equatable/equatable.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/coach_model.dart';

abstract class TrainersState extends Equatable {
  const TrainersState();

  @override
  List<Object?> get props => [];
}

class TrainersInitial extends TrainersState {}

class TrainersLoading extends TrainersState {}

class TrainersLoaded extends TrainersState {
  final List<CoachResponse> allTrainers;
  final List<CoachResponse> filteredTrainers;
  final String searchQuery;

  const TrainersLoaded({
    required this.allTrainers,
    required this.filteredTrainers,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [allTrainers, filteredTrainers, searchQuery];
}

class TrainersError extends TrainersState {
  final String message;

  const TrainersError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddCoachLoading extends TrainersState {}

class AddCoachSuccess extends TrainersState {
  final CoachResponse coach;
  const AddCoachSuccess(this.coach);

  @override
  List<Object?> get props => [coach];
}

class AddCoachError extends TrainersState {
  final String message;
  const AddCoachError(this.message);

  @override
  List<Object?> get props => [message];
}
