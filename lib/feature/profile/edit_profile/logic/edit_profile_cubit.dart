import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({
    required String initialName,
    String? initialImageUrl,
  }) : super(EditProfileState(
          initialName: initialName,
          currentName: initialName,
          initialImageUrl: initialImageUrl,
        ));

  void updateName(String newName) {
    emit(state.copyWith(currentName: newName));
  }

  void updateImage(File newImage) {
    emit(state.copyWith(currentImageFile: newImage));
  }

  Future<void> saveChanges() async {
    if (!state.isChanged) return;

    emit(state.copyWith(isLoading: true));

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

    emit(state.copyWith(isLoading: false, isSuccess: true));
  }
}
