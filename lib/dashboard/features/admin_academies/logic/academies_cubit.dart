import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/application/feature/sports/data/repo/academy_repo.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart'
    as api_model;
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'academies_state.dart';

class AcademiesCubit extends Cubit<AcademiesState> {
  AcademiesCubit() : super(AcademiesInitial());

  Future<({bool success, String? error})> loadAcademies({
    bool showLoading = true,
    String? searchQuery,
  }) async {
    final currentSearch = searchQuery ?? _currentSearchQuery;
    if (showLoading) {
      emit(AcademiesLoading());
    }

    final result = await AcademyRepo.getAcademies();
    if (result.response != null) {
      final academies = result.response!.map((apiModel) {
        String imgUrl = apiModel.imageUrl ?? '';
        if (imgUrl.isNotEmpty && !imgUrl.startsWith('http')) {
          if (imgUrl.startsWith('/')) {
            imgUrl = '${Apis.baseUrl}$imgUrl';
          } else {
            imgUrl = '${Apis.baseUrl}/$imgUrl';
          }
        }
        return Academy(
          academyId: apiModel.id?.toString() ?? '',
          name: apiModel.name ?? '',
          category: apiModel.type ?? '',
          description: apiModel.description ?? '',
          isActive: apiModel.isActive ?? true,
          imageUrl: imgUrl,
        );
      }).toList();

      _emitLoadedState(academies, currentSearch);
      return (success: true, error: null);
    } else {
      final error = result.error ?? "Failed to load academies";
      if (showLoading) {
        emit(AcademiesError(error));
      }
      return (success: false, error: error);
    }
  }

  void searchAcademies(String query) {
    final currentState = state;
    if (currentState is AcademiesLoaded) {
      _emitLoadedState(currentState.allAcademies, query);
    } else if (currentState is DeleteAcademyLoading) {
      _emitLoadedState(currentState.allAcademies, query);
    } else if (currentState is DeleteAcademySuccess) {
      _emitLoadedState(currentState.allAcademies, query);
    } else if (currentState is DeleteAcademyError) {
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

    emit(
      AcademiesLoaded(
        allAcademies: allAcademies,
        filteredAcademies: filtered,
        searchQuery: query,
      ),
    );
  }

  String get _currentSearchQuery {
    final currentState = state;
    if (currentState is AcademiesLoaded) {
      return currentState.searchQuery;
    } else if (currentState is DeleteAcademyLoading) {
      return currentState.searchQuery;
    } else if (currentState is DeleteAcademySuccess) {
      return currentState.searchQuery;
    } else if (currentState is DeleteAcademyError) {
      return currentState.searchQuery;
    }
    return '';
  }

  Future<({api_model.AcademyModel? response, String? error})> addAcademy(
    api_model.AcademyModel academyModel,
  ) async {
    final currentSearch = _currentSearchQuery;
    emit(AddAcademyLoading());
    try {
      final result = await AcademyRepo.addAcademy(academyModel);
      if (result.response != null) {
        final refreshResult = await loadAcademies(
          showLoading: false,
          searchQuery: currentSearch,
        );

        if (refreshResult.success) {
          return result;
        }

        final error =
            refreshResult.error ?? "Academy added, but failed to refresh list";
        emit(AddAcademyError(error));
        return (response: null, error: error);
      } else {
        emit(AddAcademyError(result.error ?? "Failed to add academy"));
        return (response: null, error: result.error);
      }
    } catch (e) {
      emit(AddAcademyError(e.toString()));
      return (response: null, error: e.toString());
    }
  }

  Future<void> deleteAcademy(String academyId) async {
    final currentState = state;
    
    List<Academy> allAcademies = [];
    List<Academy> filteredAcademies = [];
    String searchQuery = '';

    if (currentState is AcademiesLoaded) {
      allAcademies = currentState.allAcademies;
      filteredAcademies = currentState.filteredAcademies;
      searchQuery = currentState.searchQuery;
    } else if (currentState is DeleteAcademyLoading) {
      allAcademies = currentState.allAcademies;
      filteredAcademies = currentState.filteredAcademies;
      searchQuery = currentState.searchQuery;
    } else if (currentState is DeleteAcademySuccess) {
      allAcademies = currentState.allAcademies;
      filteredAcademies = currentState.filteredAcademies;
      searchQuery = currentState.searchQuery;
    } else if (currentState is DeleteAcademyError) {
      allAcademies = currentState.allAcademies;
      filteredAcademies = currentState.filteredAcademies;
      searchQuery = currentState.searchQuery;
    }

    final id = int.tryParse(academyId);
    if (id == null) {
      emit(DeleteAcademyError(
        message: "Invalid academy ID format",
        allAcademies: allAcademies,
        filteredAcademies: filteredAcademies,
        searchQuery: searchQuery,
      ));
      return;
    }

    final originalAll = List<Academy>.from(allAcademies);
    final originalFiltered = List<Academy>.from(filteredAcademies);

    final updatedAll = allAcademies.where((a) => a.academyId != academyId).toList();
    final updatedFiltered = filteredAcademies.where((a) => a.academyId != academyId).toList();

    emit(AcademiesLoaded(
      allAcademies: updatedAll,
      filteredAcademies: updatedFiltered,
      searchQuery: searchQuery,
    ));

    emit(DeleteAcademyLoading(
      allAcademies: updatedAll,
      filteredAcademies: updatedFiltered,
      searchQuery: searchQuery,
    ));

    try {
      final result = await AcademyRepo.deleteAcademy(id);
      if (result.success) {
        emit(DeleteAcademySuccess(
          allAcademies: updatedAll,
          filteredAcademies: updatedFiltered,
          searchQuery: searchQuery,
        ));
        await loadAcademies(showLoading: false, searchQuery: searchQuery);
      } else {
        emit(AcademiesLoaded(
          allAcademies: originalAll,
          filteredAcademies: originalFiltered,
          searchQuery: searchQuery,
        ));
        emit(DeleteAcademyError(
          message: result.error ?? "Failed to delete academy",
          allAcademies: originalAll,
          filteredAcademies: originalFiltered,
          searchQuery: searchQuery,
        ));
      }
    } catch (e) {
      emit(AcademiesLoaded(
        allAcademies: originalAll,
        filteredAcademies: originalFiltered,
        searchQuery: searchQuery,
      ));
      emit(DeleteAcademyError(
        message: e.toString(),
        allAcademies: originalAll,
        filteredAcademies: originalFiltered,
        searchQuery: searchQuery,
      ));
    }
  }
}
