import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/feature/auth/cubit/auth_state.dart';
import 'package:smart_sport_club/feature/auth/data/model/params/auth_login_params.dart';
import 'package:smart_sport_club/feature/auth/data/model/params/auth_register_params.dart';
import 'package:smart_sport_club/feature/auth/data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController clubCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    emit(AuthLoadingState());
    var params = AuthRegisterParams(
      password: passwordController.text,
      fullName: fullNameController.text,
      phoneNumber: phoneController.text,
      nationalId: nationalIdController.text,
      email: emailController.text,
      isAdmin: false, // Default for member registration
    );
    var result = await AuthRepo.register(params);
    if (result.response != null) {
      emit(AuthLoadedState());
    } else {
      emit(AuthErrorState(massage: result.error ?? "something wrong"));
    }
  }

  Future<void> login({bool isAdmin = false}) async {
    emit(AuthLoadingState());
    var params = AuthLoginParams(
      email: emailController.text,
      clubCode: clubCodeController.text,
      password: passwordController.text,
      isAdmin: isAdmin,
    );
    var result = await AuthRepo.login(params);
    if (result.response != null) {
      emit(AuthLoadedState());
    } else {
      emit(AuthErrorState(massage: result.error ?? "something wrong"));
    }
  }
}
