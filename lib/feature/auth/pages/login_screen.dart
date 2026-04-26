import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_sport_club/feature/auth/cubit/auth_state.dart';
import 'package:smart_sport_club/feature/auth/widgets/text_field_withlabel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          log("loading");
        } else if (state is AuthLoadedState) {
          log("done");
          context.go(AppRoutes.mainApp);
        } else if (state is AuthErrorState) {
          log("Failure: ${state.massage}");
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Club Access",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.chevron_left, size: 32.w, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: context.read<AuthCubit>().formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMembershipCard(),
                        30.H,
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.H,
                        TextFieldWithlabel(
                          controller: context.read<AuthCubit>().emailController,
                          path: AppImages.idIconSvg,
                          label: "Email Address",
                          hint: "example@club.com",
                          validator: AppValidators.email,
                        ),
                        16.H,
                        TextFieldWithlabel(
                          controller: context
                              .read<AuthCubit>()
                              .clubCodeController,
                          validator: AppValidators.clubCode,
                          path: AppImages.sequenceSvg,
                          label: "Club Code",
                          hint: "XXXX-XXXX-XXXX",
                        ),
                        16.H,
                        TextFieldWithlabel(
                          controller: context
                              .read<AuthCubit>()
                              .passwordController,
                          obscureText: _obscurePassword,
                          suffixIcon: InkWell(
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                            ),
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: AppValidators.password,
                          path: AppImages.lockSvg,
                          label: "Password",
                          hint: "********",
                        ),
                        10.H,
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.push(AppRoutes.requestPassword);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyles.caption1.copyWith(
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        20.H,
                        MainButton(
                          text: "Sign In to Club",
                          onPressed: () {
                            if (context
                                .read<AuthCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<AuthCubit>().login();
                            }
                          },
                        ),
                        25.H,
                        TextWithDifferentColor(
                          text1: "Don't have an account? ",
                          text2: 'Register Now',
                          onTap: () {
                            context.push(AppRoutes.register);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        gradient: const LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 40.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "PREMIUM MEMBER",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10.sp,
                  letterSpacing: 2.w,
                ),
              ),
              Text(
                "Elite Sports Club",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "DIGITAL ACCESS KEY",
                style: TextStyle(color: Colors.white70, fontSize: 10.sp),
              ),
              Text(
                "•••• •••• •••• 9842",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  letterSpacing: 2.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
