import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/dialog.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/application/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_sport_club/application/feature/auth/cubit/auth_state.dart';
import 'package:smart_sport_club/application/feature/auth/widgets/build_field_label.dart';
import 'package:smart_sport_club/application/feature/auth/widgets/custom_clickable_containers.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          log("loading");
          showLoadingDialog(context);
        } else if (state is AuthLoadedState) {
          Navigations.pop(context);
          log("done");
          context.go(AppRoutes.mainApp);
        } else if (state is AuthErrorState) {
          Navigations.pop(context);
          log("Failure: ${state.massage}");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white, size: 32.w),
            onPressed: () => context.pop(),
          ),
          title: Text(
            "Member Registration",
            style: TextStyles.title.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: context.read<AuthCubit>().formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(35.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40.w),
                      border: Border.all(color: Colors.white12, width: 1.w),
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      size: 80.w,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Join the Club",
                  style: TextStyles.hugeHeadLine.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  "Create your account to start booking football fields and join local tournaments.",
                  style: TextStyles.body.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                SizedBox(height: 30.h),
                const BuildFieldLabel(label: "Full Name"),
                CustomTextFormField(
                  controller: context.read<AuthCubit>().fullNameController,
                  hintText: "John Doe",
                  validator: AppValidators.name,
                  prefixIcon: Icon(
                    Icons.person,
                    color: const Color(0xff5C6D65),
                    size: 20.w,
                  ),
                ),
                SizedBox(height: 20.h),
                const BuildFieldLabel(label: "Email Address"),
                CustomTextFormField(
                  controller: context.read<AuthCubit>().emailController,
                  hintText: "example@club.com",
                  validator: AppValidators.email,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: const Color(0xff5C6D65),
                    size: 20.w,
                  ),
                ),
                SizedBox(height: 20.h),
                const BuildFieldLabel(label: "Phone Number"),
                CustomTextFormField(
                  controller: context.read<AuthCubit>().phoneController,
                  validator: AppValidators.phone,
                  hintText: "01234567890",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: const Color(0xff5C6D65),
                    size: 20.w,
                  ),
                ),
                SizedBox(height: 30.h),
                const BuildFieldLabel(label: "National ID"),
                CustomTextFormField(
                  controller: context.read<AuthCubit>().nationalIdController,
                  validator: AppValidators.requiredField,
                  hintText: "14-digit national ID",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: const Color(0xff5C6D65),
                    size: 20.w,
                  ),
                ),
                SizedBox(height: 30.h),
                const BuildFieldLabel(label: "Create Password"),
                CustomTextFormField(
                  controller: context.read<AuthCubit>().passwordController,
                  validator: AppValidators.password,
                  hintText: "**********",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: const Color(0xff5C6D65),
                    size: 20.w,
                  ),
                  // obscureText: _obscureText,
                  // suffixIcon: InkWell(
                  //   child: Icon(
                  //     _obscureText
                  //         ? Icons.visibility
                  //         : Icons.visibility_off_outlined,
                  //     size: 20.w,
                  //   ),
                  //   onTap: () {
                  //     setState(() {
                  //       _obscureText = !_obscureText;
                  //     });
                  //   },
                  // ),
                ),
                SizedBox(height: 30.h),
                SizedBox(height: 30.h),
                CustomClickableContainer(
                  text: "Register Account",
                  prefixIcon: Icon(
                    Icons.person_add_alt_1_outlined,
                    color: AppColors.primaryGreen,
                    size: 24.w,
                  ),
                  onTap: () {
                    if (context
                        .read<AuthCubit>()
                        .formKey
                        .currentState!
                        .validate()) {
                      context.read<AuthCubit>().register();
                    }
                  },
                ),
                SizedBox(height: 20.h),
                TextWithDifferentColor(
                  text1: "Already have an account? ",
                  text2: 'Log in',
                  onTap: () {
                    context.push(AppRoutes.login);
                  },
                ),
                32.H,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
