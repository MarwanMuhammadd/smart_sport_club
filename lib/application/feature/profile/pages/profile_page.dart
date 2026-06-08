import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/local/shared_pref.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/application/feature/profile/widgets/logout_button.dart';
import 'package:smart_sport_club/application/feature/profile/widgets/profile_header.dart';
import 'package:smart_sport_club/application/feature/profile/widgets/profile_menu_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name;
  late String imageUrl;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    name = SharedPref.getUserName().trim();
    imageUrl = AppImages.userAvatarPlaceholderSvg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor:Colors.green,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
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
              ProfileHeader(
                name: name,
                imageUrl: imageUrl,
                imageFile: imageFile,
                onEditTap: () async {
                  final result = await context.push<Map<String, dynamic>?>(
                    AppRoutes.editProfile,
                    extra: {
                      'initialName': name,
                      'initialImageUrl': imageUrl,
                      'initialImageFile': imageFile,
                    },
                  );

                  if (result != null) {
                    setState(() {
                      if (result['name'] != null) {
                        name = result['name'];
                      }
                      if (result['imageFile'] != null) {
                        imageFile = result['imageFile'];
                      }
                    });
                  }
                },
              ),
              32.H,

              // Menu Items section
              ProfileMenuItem(
                icon: Icons.card_membership,
                title: "Renew Membership",
                iconColor: AppColors.primaryGreen,
                iconBackgroundColor: AppColors.primaryGreen.withOpacity(0.1),
                onTap: () {
                  context.push(AppRoutes.renewMembership);
                },
              ),
              ProfileMenuItem(
                icon: Icons.calendar_today,
                title: "My Bookings",
                iconColor: AppColors.lightBlue,
                iconBackgroundColor: AppColors.lightBlue.withOpacity(0.1),
                onTap: () {
                  context.push(AppRoutes.myBookings);
                },
              ),
              ProfileMenuItem(
                icon: Icons.settings,
                title: "Settings",
                iconColor: AppColors.secondaryColor,
                iconBackgroundColor: AppColors.secondaryColor.withOpacity(0.1),
                onTap: () {
                  // Handle settings tap
                },
              ),

              48.H,
              // Logout section
              LogoutButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (sheetContext) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.w),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 36.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Handle bar
                            Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                            ),
                            24.H,
                            // Icon
                            Container(
                              width: 64.w,
                              height: 64.w,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.logout_rounded,
                                color: Colors.red,
                                size: 32.w,
                              ),
                            ),
                            16.H,
                            // Title
                            Text(
                              "Logout",
                              style: TextStyles.headline.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            8.H,
                            // Subtitle
                            Text(
                              "Are you sure you want to logout?",
                              textAlign: TextAlign.center,
                              style: TextStyles.body.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            28.H,
                            // Buttons
                            Row(
                              children: [
                                // Cancel button
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.pop(sheetContext),
                                    borderRadius: BorderRadius.circular(12.w),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 14.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(12.w),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Cancel",
                                        style: TextStyles.body.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                12.W,
                                // Yes, Logout button
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(sheetContext);
                                      context.go(AppRoutes.login);
                                    },
                                    borderRadius: BorderRadius.circular(12.w),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 14.h),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(12.w),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Yes, Logout",
                                        style: TextStyles.body.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              24.H,
            ],
          ),
        ),
      ),
    );
  }
}
