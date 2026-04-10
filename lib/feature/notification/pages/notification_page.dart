import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/notification/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 24.w,
        title: Row(
          children: [
            Icon(Icons.notifications, color: AppColors.primaryGreen, size: 28.w),
            12.W,
            Text(
              "Notifications",
              style: TextStyles.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontSize: 22.sp,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.secondaryText, size: 24.w),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RECENT ALERTS",
                style: TextStyles.caption2.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.secondaryText.withOpacity(0.8),
                ),
              ),
              24.H,
              
              // 1. Football
              const NotificationCard(
                title: "Booking Confirmed!",
                timeAgo: "2h ago",
                description: "Your football field booking for tomorrow at 5:00 PM is confirmed.",
                icon: Icons.sports_soccer,
                baseColor: AppColors.primaryGreen,
              ),
              
              // 2. Swimming
              const NotificationCard(
                title: "New Challenge!",
                timeAgo: "5h ago",
                description: "Join the Swimming Sprint Challenge this weekend and win a trophy.",
                icon: Icons.pool,
                baseColor: AppColors.lightBlue,
              ),
              
              // 3. Basketball
              const NotificationCard(
                title: "Coach Update",
                timeAgo: "1d ago",
                description: "Coach Sarah Jenkins has updated the basketball training schedule.",
                icon: Icons.sports_basketball,
                baseColor: Colors.orange, // Standard orange for basket
              ),
              
              30.H,
            ],
          ),
        ),
      ),
    );
  }
}
