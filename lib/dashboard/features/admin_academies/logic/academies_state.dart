import 'package:equatable/equatable.dart';
import '../data/academy_model.dart';

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
