import 'package:equatable/equatable.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';

abstract class TrainersState extends Equatable {
  const TrainersState();

  @override
  List<Object?> get props => [];
}

class TrainersInitial extends TrainersState {}

class TrainersLoading extends TrainersState {}

class TrainersLoaded extends TrainersState {
  final List<TrainerModel> allTrainers;
  final List<TrainerModel> filteredTrainers;
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
