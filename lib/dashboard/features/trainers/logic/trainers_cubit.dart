import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';
import 'trainers_state.dart';

class TrainersCubit extends Cubit<TrainersState> {
  StreamSubscription? _subscription;

  TrainersCubit() : super(TrainersInitial());

  void subscribeToTrainers() {
    emit(TrainersLoading());
    _subscription?.cancel();
    
    _subscription = FirebaseFirestore.instance
        .collection('trainers')
        .snapshots()
        .listen((snapshot) {
      final trainers = snapshot.docs
          .map((doc) => TrainerModel.fromFirestore(doc))
          .toList();
      
      String currentSearch = '';
      if (state is TrainersLoaded) {
        currentSearch = (state as TrainersLoaded).searchQuery;
      }

      _emitLoadedState(trainers, currentSearch);
    }, onError: (error) {
      emit(TrainersError(error.toString()));
    });
  }

  void searchTrainers(String query) {
    if (state is TrainersLoaded) {
      final allTrainers = (state as TrainersLoaded).allTrainers;
      _emitLoadedState(allTrainers, query);
    }
  }

  void _emitLoadedState(List<TrainerModel> allTrainers, String query) {
    final filtered = query.isEmpty
        ? allTrainers
        : allTrainers
            .where((t) => t.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    emit(TrainersLoaded(
      allTrainers: allTrainers,
      filteredTrainers: filtered,
      searchQuery: query,
    ));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
