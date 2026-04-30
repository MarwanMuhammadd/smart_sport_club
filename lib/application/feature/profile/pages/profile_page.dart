import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  String name = "Julian Alvarez";
  String imageUrl =
      "https://lh3.googleusercontent.com/aida-public/AB6AXuBE1FuA12FaeNZ3Ihc4di5k9KutJQhVDYRhQhvgYTiliUovi_X6cj4rZ4K1rRLdqa_Cm97u_BEtqFPoaEFvmQvoH8RxC0GSqIkSSdAs-xFlV7Tf_3x_hza_mzrloJpqSC07VbFFASKi1vj4F2NjZZKftJp2kcnt1gfvxGEt5MaEE21YwvR9xC9M2ctVg-r4VmNs8pVkkBHcgtT5QsNdtvisvh6lJDhP6NCddsqUwOhP0Kgv-6mtgwew3qiOyOm5TFC_2x9009rYDDQE";
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                  context.go(AppRoutes.login);
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
