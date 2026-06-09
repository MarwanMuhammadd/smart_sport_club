import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/application/feature/sports/data/repo/academy_repo.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart' as api_model;
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'academies_state.dart';

class AcademiesCubit extends Cubit<AcademiesState> {
  AcademiesCubit() : super(AcademiesInitial());

  Future<void> loadAcademies() async {
    emit(AcademiesLoading());
    
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

      String currentSearch = '';
      if (state is AcademiesLoaded) {
        currentSearch = (state as AcademiesLoaded).searchQuery;
      }

      _emitLoadedState(academies, currentSearch);
    } else {
      emit(AcademiesError(result.error ?? "Failed to load academies"));
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

    emit(AcademiesLoaded(
      allAcademies: allAcademies,
      filteredAcademies: filtered,
      searchQuery: query,
    ));
  }
  Future<({api_model.AcademyModel? response, String? error})> addAcademy(
    api_model.AcademyModel academyModel,
  ) async {
    emit(AddAcademyLoading());
    try {
      final result = await AcademyRepo.addAcademy(academyModel);
      if (result.response != null) {
        emit(AddAcademySuccess(result.response!));
        await loadAcademies();
        return result;
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
