import 'package:equatable/equatable.dart';

abstract class DashboardStatsState extends Equatable {
  const DashboardStatsState();

  @override
  List<Object?> get props => [];
}

class DashboardStatsInitial extends DashboardStatsState {}

class DashboardStatsLoading extends DashboardStatsState {}

class DashboardStatsLoaded extends DashboardStatsState {
  final int totalMembers;
  final int totalTrainers;
  final int totalAcademies;
  final int activeOffers;

  const DashboardStatsLoaded({
    required this.totalMembers,
    required this.totalTrainers,
    required this.totalAcademies,
    required this.activeOffers,
  });

  @override
  List<Object?> get props => [
        totalMembers,
        totalTrainers,
        totalAcademies,
        activeOffers,
      ];
}

class DashboardStatsError extends DashboardStatsState {
  final String message;

  const DashboardStatsError(this.message);

  @override
  List<Object?> get props => [message];
}
