import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/notification/logic/notification_cubit.dart';
import 'package:smart_sport_club/feature/notification/logic/notification_state.dart';
import 'package:smart_sport_club/feature/notification/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  String _formatTimeAgo(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inDays > 0) return '${duration.inDays}d ago';
    if (duration.inHours > 0) return '${duration.inHours}h ago';
    if (duration.inMinutes > 0) return '${duration.inMinutes}m ago';
    return 'Just now';
  }

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
            Icon(
              Icons.notifications,
              color: AppColors.primaryGreen,
              size: 28.w,
            ),
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
              icon: Icon(
                Icons.more_vert,
                color: AppColors.secondaryText,
                size: 24.w,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_none,
                        size: 64.w, color: AppColors.accentGrey),
                    16.H,
                    Text("No notifications yet",
                        style: TextStyles.body.copyWith(color: AppColors.accentGrey)),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
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
                    ...state.notifications.map((notification) {
                      return NotificationCard(
                        title: notification.title,
                        timeAgo: _formatTimeAgo(notification.time),
                        description: notification.description,
                        icon: notification.icon,
                        baseColor: notification.color,
                        onViewDetails: () {
                          if (notification.extraData is BookingModel) {
                            context.push(
                              AppRoutes.bookingSuccess,
                              extra: notification.extraData,
                            );
                          }
                        },
                      );
                    }),
                    30.H,
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
