import 'dart:io';

class EditProfileState {
  final String currentName;
  final String initialName;
  final File? currentImageFile;
  final String? initialImageUrl;
  final bool isLoading;
  final bool isSuccess;

  EditProfileState({
    required this.currentName,
    required this.initialName,
    this.currentImageFile,
    this.initialImageUrl,
    this.isLoading = false,
    this.isSuccess = false,
  });

  bool get isChanged => currentName != initialName || currentImageFile != null;

  EditProfileState copyWith({
    String? currentName,
    String? initialName,
    File? currentImageFile,
    String? initialImageUrl,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return EditProfileState(
      currentName: currentName ?? this.currentName,
      initialName: initialName ?? this.initialName,
      currentImageFile: currentImageFile ?? this.currentImageFile,
      initialImageUrl: initialImageUrl ?? this.initialImageUrl,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
