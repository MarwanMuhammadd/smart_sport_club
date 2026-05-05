import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/dashboard/features/admin_academies/data/academy_model.dart';
import '../data/mock_academies_data.dart';
import 'academies_state.dart';

class AcademiesCubit extends Cubit<AcademiesState> {
  AcademiesCubit() : super(AcademiesInitial());

  void loadAcademies() {
    emit(AcademiesLoading());
    // Simulate a small delay for better UX
    Future.delayed(const Duration(milliseconds: 500), () {
      final academies = MockAcademiesData.academies;
      emit(AcademiesLoaded(
        allAcademies: academies,
        filteredAcademies: academies,
      ));
    });
  }

  void searchAcademies(String query) {
    if (state is AcademiesLoaded) {
      final currentState = state as AcademiesLoaded;
      
      if (query.isEmpty) {
        emit(AcademiesLoaded(
          allAcademies: currentState.allAcademies,
          filteredAcademies: currentState.allAcademies,
          searchQuery: '',
        ));
        return;
      }

      final filtered = currentState.allAcademies.where((academy) {
        return academy.name.toLowerCase().contains(query.toLowerCase()) ||
               academy.category.toLowerCase().contains(query.toLowerCase());
      }).toList();

      emit(AcademiesLoaded(
        allAcademies: currentState.allAcademies,
        filteredAcademies: filtered,
        searchQuery: query,
      ));
    }
  }

  void addAcademy(Academy academy) {
    if (state is AcademiesLoaded) {
      final currentState = state as AcademiesLoaded;
      final updatedAll = List<Academy>.from(currentState.allAcademies)..add(academy);
      
      // If there's a search query, we should ideally filter again, 
      // but for simplicity we'll just add it to the filtered list if it matches or if search is empty.
      final updatedFiltered = List<Academy>.from(currentState.filteredAcademies)..add(academy);
      
      emit(AcademiesLoaded(
        allAcademies: updatedAll,
        filteredAcademies: updatedFiltered,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void deleteAcademy(String academyId) {
    if (state is AcademiesLoaded) {
      final currentState = state as AcademiesLoaded;
      
      final updatedAll = currentState.allAcademies.where((a) => a.id != academyId).toList();
      final updatedFiltered = currentState.filteredAcademies.where((a) => a.id != academyId).toList();
      
      emit(AcademiesLoaded(
        allAcademies: updatedAll,
        filteredAcademies: updatedFiltered,
        searchQuery: currentState.searchQuery,
      ));
    }
  }
}
