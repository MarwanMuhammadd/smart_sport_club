import 'package:equatable/equatable.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart' as api_model;

abstract class AcademiesState extends Equatable {
  const AcademiesState();

  @override
  List<Object?> get props => [];
}

class AcademiesInitial extends AcademiesState {}

class AcademiesLoading extends AcademiesState {}

class AcademiesLoaded extends AcademiesState {
  final List<Academy> allAcademies;
  final List<Academy> filteredAcademies;
  final String searchQuery;

  const AcademiesLoaded({
    required this.allAcademies,
    required this.filteredAcademies,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [allAcademies, filteredAcademies, searchQuery];
}

class AcademiesError extends AcademiesState {
  final String message;

  const AcademiesError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddAcademyLoading extends AcademiesState {}

class AddAcademySuccess extends AcademiesState {
  final api_model.AcademyModel academy;
  const AddAcademySuccess(this.academy);

  @override
  List<Object?> get props => [academy];
}

class AddAcademyError extends AcademiesState {
  final String message;
  const AddAcademyError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteAcademyLoading extends AcademiesState {
  final List<Academy> allAcademies;
  final List<Academy> filteredAcademies;
  final String searchQuery;

  const DeleteAcademyLoading({
    required this.allAcademies,
    required this.filteredAcademies,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [allAcademies, filteredAcademies, searchQuery];
}

class DeleteAcademySuccess extends AcademiesState {
  final List<Academy> allAcademies;
  final List<Academy> filteredAcademies;
  final String searchQuery;

  const DeleteAcademySuccess({
    required this.allAcademies,
    required this.filteredAcademies,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [allAcademies, filteredAcademies, searchQuery];
}

class DeleteAcademyError extends AcademiesState {
  final String message;
  final List<Academy> allAcademies;
  final List<Academy> filteredAcademies;
  final String searchQuery;

  const DeleteAcademyError({
    required this.message,
    required this.allAcademies,
    required this.filteredAcademies,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [message, allAcademies, filteredAcademies, searchQuery];
}


