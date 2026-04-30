import 'dart:io';

class EditProfileState {
  final String currentName;
  final String initialName;
  final File? currentImageFile;
  final File? initialImageFile;
  final String? initialImageUrl;
  final bool isLoading;
  final bool isSuccess;

  EditProfileState({
    required this.currentName,
    required this.initialName,
    this.currentImageFile,
    this.initialImageFile,
    this.initialImageUrl,
    this.isLoading = false,
    this.isSuccess = false,
  });

  bool get isChanged =>
      currentName != initialName || currentImageFile != initialImageFile;

  EditProfileState copyWith({
    String? currentName,
    String? initialName,
    File? currentImageFile,
    File? initialImageFile,
    String? initialImageUrl,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return EditProfileState(
      currentName: currentName ?? this.currentName,
      initialName: initialName ?? this.initialName,
      currentImageFile: currentImageFile ?? this.currentImageFile,
      initialImageFile: initialImageFile ?? this.initialImageFile,
      initialImageUrl: initialImageUrl ?? this.initialImageUrl,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
