import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'academies_state.dart';

class AcademiesCubit extends Cubit<AcademiesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _academiesSubscription;

  AcademiesCubit() : super(AcademiesInitial());

  void loadAcademies() {
    emit(AcademiesLoading());
    
    _academiesSubscription?.cancel();
    _academiesSubscription = _firestore
        .collection('academies')
        .snapshots()
        .listen((snapshot) {
      final academies = snapshot.docs
          .map((doc) => Academy.fromMap(doc.data(), doc.id))
          .toList();
      
      String currentSearch = '';
      if (state is AcademiesLoaded) {
        currentSearch = (state as AcademiesLoaded).searchQuery;
      }

      _emitLoadedState(academies, currentSearch);
    }, onError: (error) {
      emit(AcademiesError(error.toString()));
    });
  }

  void searchAcademies(String query) {
    if (state is AcademiesLoaded) {
      final currentState = state as AcademiesLoaded;
      _emitLoadedState(currentState.allAcademies, query);
    }
  }

  void _emitLoadedState(List<Academy> allAcademies, String query) {
    final filtered = query.isEmpty
        ? allAcademies
        : allAcademies.where((academy) {
            return academy.name.toLowerCase().contains(query.toLowerCase()) ||
                   academy.category.toLowerCase().contains(query.toLowerCase());
          }).toList();

    emit(AcademiesLoaded(
      allAcademies: allAcademies,
      filteredAcademies: filtered,
      searchQuery: query,
    ));
  }

  Future<void> addAcademy(Academy academy) async {
    try {
      final docRef = _firestore.collection('academies').doc();
      final newAcademy = academy.copyWith(academyId: docRef.id);
      await docRef.set(newAcademy.toMap());
    } catch (e) {
      emit(AcademiesError(e.toString()));
    }
  }

  Future<void> deleteAcademy(String academyId) async {
    try {
      await _firestore.collection('academies').doc(academyId).delete();
    } catch (e) {
      emit(AcademiesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _academiesSubscription?.cancel();
    return super.close();
  }
}
