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
      emit(AcademiesError(error));
      return (success: false, error: error);
    }
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
    try {
      final id = int.tryParse(academyId);
      if (id == null) {
        emit(AcademiesError("Invalid academy ID format"));
        return;
      }

      final result = await AcademyRepo.deleteAcademy(id);
      if (result.success) {
        await loadAcademies();
      } else {
        emit(AcademiesError(result.error ?? "Failed to delete academy"));
      }
    } catch (e) {
      emit(AcademiesError(e.toString()));
    }
  }
}
