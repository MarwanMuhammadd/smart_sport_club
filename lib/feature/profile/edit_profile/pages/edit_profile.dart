import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/image_picker_helper.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/profile/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_sport_club/feature/profile/edit_profile/logic/edit_profile_state.dart';
import 'package:smart_sport_club/feature/profile/edit_profile/widgets/edit_header.dart';

class EditProfile extends StatefulWidget {
  final String initialName;
  final String initialImageUrl;

  const EditProfile({
    super.key,
    this.initialName = "Julian Alvarez",
    this.initialImageUrl =
        "https://lh3.googleusercontent.com/aida-public/AB6AXuBE1FuA12FaeNZ3Ihc4di5k9KutJQhVDYRhQhvgYTiliUovi_X6cj4rZ4K1rRLdqa_Cm97u_BEtqFPoaEFvmQvoH8RxC0GSqIkSSdAs-xFlV7Tf_3x_hza_mzrloJpqSC07VbFFASKi1vj4F2NjZZKftJp2kcnt1gfvxGEt5MaEE21YwvR9xC9M2ctVg-r4VmNs8pVkkBHcgtT5QsNdtvisvh6lJDhP6NCddsqUwOhP0Kgv-6mtgwew3qiOyOm5TFC_2x9009rYDDQE",
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop({
            'name': state.currentName,
            'imageFile': state.currentImageFile,
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.chevron_left_rounded,
                color: AppColors.primaryColor,
                size: 30.w,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Edit Profile",
              style: TextStyles.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  // Profile Header section
                  EditHeader(
                    imageUrl: widget.initialImageUrl,
                    imageFile: state.currentImageFile,
                    onImageTap: () => ImagePickerHelper.showImagePickerBottomSheet(
                      context: context,
                      onImagePicked: (file) {
                        context.read<EditProfileCubit>().updateImage(file);
                      },
                    ),
                  ),
                  Text(
                    state.currentImageFile != null
                        ? "Photo changed!"
                        : "Tap to change photo",
                    style: TextStyles.caption1.copyWith(
                      color: state.currentImageFile != null
                          ? AppColors.primaryGreen
                          : AppColors.primaryColor,
                    ),
                  ),
                  40.H,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Full Name"),
                  ),
                  10.H,
                  CustomTextFormField(
                    controller: _nameController,
                    onChanged: (val) {
                      context.read<EditProfileCubit>().updateName(val);
                    },
                  ),
                  60.H,
                  MainButton(
                    text: "Save",
                    isDisabled: !state.isChanged,
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<EditProfileCubit>().saveChanges();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
