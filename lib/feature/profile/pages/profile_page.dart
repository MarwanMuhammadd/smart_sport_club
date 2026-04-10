import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/profile/widgets/logout_button.dart';
import 'package:smart_sport_club/feature/profile/widgets/profile_header.dart';
import 'package:smart_sport_club/feature/profile/widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // Optional back button if needed, but since it's a bottom nav tab, usually it's omitted.
        // I will include the title and the trailing button as in the HTML.
        title: Text(
          "Profile",
          style: TextStyles.title.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.primaryColor,
              size: 24.w,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              // Profile Header section
              const ProfileHeader(
                name: "Julian Alvarez",
                email: "j.alvarez@sportsclub.com",
                imageUrl:
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBE1FuA12FaeNZ3Ihc4di5k9KutJQhVDYRhQhvgYTiliUovi_X6cj4rZ4K1rRLdqa_Cm97u_BEtqFPoaEFvmQvoH8RxC0GSqIkSSdAs-xFlV7Tf_3x_hza_mzrloJpqSC07VbFFASKi1vj4F2NjZZKftJp2kcnt1gfvxGEt5MaEE21YwvR9xC9M2ctVg-r4VmNs8pVkkBHcgtT5QsNdtvisvh6lJDhP6NCddsqUwOhP0Kgv-6mtgwew3qiOyOm5TFC_2x9009rYDDQE",
              ),
              32.H,

              // Menu Items section
              ProfileMenuItem(
                icon: Icons.card_membership,
                title: "Renew Membership",
                iconColor: AppColors.primaryGreen,
                iconBackgroundColor: AppColors.primaryGreen.withOpacity(0.1),
                onTap: () {
                  // Handle renew membership tap
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
                  // Handle logout
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
