import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/repo/academy_repo.dart';
import 'dashboard_stats_state.dart';

class DashboardStatsCubit extends Cubit<DashboardStatsState> {
  DashboardStatsCubit() : super(DashboardStatsInitial());

  final _firestore = FirebaseFirestore.instance;

  /// Fetches all counts in parallel to minimise latency.
  Future<void> loadStats() async {
    emit(DashboardStatsLoading());
    try {
      final firestoreCalls = Future.wait([
        _firestore.collection('users').count().get(),
        _firestore.collection('trainers').count().get(),
        _firestore
            .collection('offers')
            .where('isActive', isEqualTo: true)
            .count()
            .get(),
      ]);

      final apiCalls = AcademyRepo.getAcademies();

      final results = await Future.wait([
        firestoreCalls,
        apiCalls,
      ]);

      final firestoreResults = results[0] as List<AggregateQuerySnapshot>;
      final academiesResult = results[1] as ({List<AcademyModel>? response, String? error});

      emit(DashboardStatsLoaded(
        totalMembers: firestoreResults[0].count ?? 0,
        totalTrainers: firestoreResults[1].count ?? 0,
        totalAcademies: academiesResult.response?.length ?? 0,
        activeOffers: firestoreResults[2].count ?? 0,
      ));
    } catch (e) {
      emit(DashboardStatsError(e.toString()));
    }
  }
}
