import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/coach_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/repo/coach_repo.dart';
import 'trainers_state.dart';

class TrainersCubit extends Cubit<TrainersState> {
  TrainersCubit() : super(TrainersInitial());

  Future<void> loadTrainers() async {
    emit(TrainersLoading());
    try {
      final trainers = await CoachRepo.getCoaches();
      String currentSearch = '';
      if (state is TrainersLoaded) {
        currentSearch = (state as TrainersLoaded).searchQuery;
      }
      _emitLoadedState(trainers, currentSearch);
    } catch (e) {
      emit(TrainersError(e.toString()));
    }
  }

  void subscribeToTrainers() {
    loadTrainers();
  }

  Future<({CoachResponse? response, String? error})> addCoach(
    CoachRequest coachRequest,
  ) async {
    emit(AddCoachLoading());
    try {
      final result = await CoachRepo.addCoach(coachRequest);
      if (result.response != null) {
        emit(AddCoachSuccess(result.response!));
        await loadTrainers();
        return result;
      } else {
        emit(AddCoachError(result.error ?? "Failed to add coach"));
        return (response: null, error: result.error);
      }
    } catch (e) {
      emit(AddCoachError(e.toString()));
      return (response: null, error: e.toString());
    }
  }

  Future<void> deleteCoach(int id) async {
    try {
      final result = await CoachRepo.deleteCoach(id);
      if (result.success) {
        await loadTrainers();
      }
    } catch (e) {
      emit(TrainersError(e.toString()));
    }
  }

  void searchTrainers(String query) {
    if (state is TrainersLoaded) {
      final allTrainers = (state as TrainersLoaded).allTrainers;
      _emitLoadedState(allTrainers, query);
    }
  }

  void _emitLoadedState(List<CoachResponse> allTrainers, String query) {
    final filtered = query.isEmpty
        ? allTrainers
        : allTrainers
            .where((t) => t.fullName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    emit(TrainersLoaded(
      allTrainers: allTrainers,
      filteredTrainers: filtered,
      searchQuery: query,
    ));
  }
}
