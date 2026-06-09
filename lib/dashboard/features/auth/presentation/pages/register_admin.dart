import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/application/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_sport_club/application/feature/auth/cubit/auth_state.dart';
import 'package:smart_sport_club/application/feature/auth/widgets/build_field_label.dart';
import 'package:smart_sport_club/application/feature/auth/widgets/custom_clickable_containers.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/dialog.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';

class AdminRegisterScreen extends StatelessWidget {
  const AdminRegisterScreen({super.key});

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
          context.go(AppRoutes.homeDashboard);
        } else if (state is AuthErrorState) {
          Navigations.pop(context);
          log("Failure: ${state.massage}");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.sidebarBorder,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            "Member Registration",
            style: TextStyles.title.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),

        // 👇 IMPORTANT: Safe scroll + center layout
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;

              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isWide ? 800 : 450,
                    ),
                    child: Form(
                      key: context.read<AuthCubit>().formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: Colors.white12),
                              ),
                              child: const Icon(
                                Icons.sports_soccer,
                                size: 64,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Join the Club",
                                  style: TextStyles.hugeHeadLine.copyWith(
                                    color: Colors.white,
                                    fontSize: isWide ? 32 : 26,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Create your account to start booking football fields and join local tournaments.",
                                  style: TextStyles.body.copyWith(
                                    color: AppColors.secondaryText,
                                    fontSize: isWide ? 15 : 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),

                          if (isWide) ...[
                            // Desktop/Tablet side-by-side layout
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const BuildFieldLabel(label: "Full Name"),
                                      CustomTextFormField(
                                        controller: context
                                            .read<AuthCubit>()
                                            .fullNameController,
                                        hintText: "John Doe",
                                        validator: AppValidators.name,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Color(0xff5C6D65),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const BuildFieldLabel(label: "Email Address"),
                                      CustomTextFormField(
                                        controller: context
                                            .read<AuthCubit>()
                                            .emailController,
                                        hintText: "example@club.com",
                                        validator: AppValidators.email,
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                          color: Color(0xff5C6D65),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const BuildFieldLabel(label: "Phone Number"),
                                      CustomTextFormField(
                                        controller: context
                                            .read<AuthCubit>()
                                            .phoneController,
                                        validator: AppValidators.phone,
                                        hintText: "01234567890",
                                        prefixIcon: const Icon(
                                          Icons.phone_outlined,
                                          color: Color(0xff5C6D65),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const BuildFieldLabel(label: "National ID"),
                                      CustomTextFormField(
                                        controller: context
                                            .read<AuthCubit>()
                                            .nationalIdController,
                                        validator: AppValidators.requiredField,
                                        hintText: "14-digit national ID",
                                        prefixIcon: const Icon(
                                          Icons.perm_identity,
                                          color: Color(0xff5C6D65),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const BuildFieldLabel(label: "Create Password"),
                                      CustomTextFormField(
                                        controller: context
                                            .read<AuthCubit>()
                                            .passwordController,
                                        validator: AppValidators.password,
                                        hintText: "**********",
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Color(0xff5C6D65),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ] else ...[
                            // Mobile stacked layout
                            const BuildFieldLabel(label: "Full Name"),
                            CustomTextFormField(
                              controller: context
                                  .read<AuthCubit>()
                                  .fullNameController,
                              hintText: "John Doe",
                              validator: AppValidators.name,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color(0xff5C6D65),
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 16),

                            const BuildFieldLabel(label: "Email Address"),
                            CustomTextFormField(
                              controller:
                                  context.read<AuthCubit>().emailController,
                              hintText: "example@club.com",
                              validator: AppValidators.email,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color(0xff5C6D65),
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 16),

                            const BuildFieldLabel(label: "Phone Number"),
                            CustomTextFormField(
                              controller:
                                  context.read<AuthCubit>().phoneController,
                              validator: AppValidators.phone,
                              hintText: "01234567890",
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: Color(0xff5C6D65),
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 16),

                            const BuildFieldLabel(label: "National ID"),
                            CustomTextFormField(
                              controller: context
                                  .read<AuthCubit>()
                                  .nationalIdController,
                              validator: AppValidators.requiredField,
                              hintText: "14-digit national ID",
                              prefixIcon: const Icon(
                                Icons.perm_identity,
                                color: Color(0xff5C6D65),
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 16),

                            const BuildFieldLabel(label: "Create Password"),
                            CustomTextFormField(
                              controller: context
                                  .read<AuthCubit>()
                                  .passwordController,
                              validator: AppValidators.password,
                              hintText: "**********",
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color(0xff5C6D65),
                                size: 20,
                              ),
                            ),
                          ],

                          const SizedBox(height: 32),

                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isWide ? 400 : double.infinity,
                              ),
                              child: CustomClickableContainer(
                                text: "Register Account",
                                prefixIcon: const Icon(
                                  Icons.person_add_alt_1_outlined,
                                  color: AppColors.primaryGreen,
                                  size: 24,
                                ),
                                onTap: () {
                                  final form = context.read<AuthCubit>().formKey.currentState;
                                  if (form != null) {
                                    if (form.validate()) {
                                      log("Form is valid, calling register()");
                                      context.read<AuthCubit>().register();
                                    } else {
                                      log("Form is invalid! Check validation errors on the screen.");
                                    }
                                  } else {
                                    log("Form key state is null.");
                                  }
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Center(
                            child: TextWithDifferentColor(
                              text1: "Already have an account? ",
                              text2: 'Log in',
                              onTap: () {
                                context.push(AppRoutes.adminLoginScreen);
                              },
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
