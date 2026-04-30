class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadedState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  String massage;
  AuthErrorState({required this.massage});
}
