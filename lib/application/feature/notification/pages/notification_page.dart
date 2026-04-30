import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_dialog.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/application/feature/notification/logic/notification_cubit.dart';
import 'package:smart_sport_club/application/feature/notification/logic/notification_state.dart';
import 'package:smart_sport_club/application/feature/notification/widgets/notification_card.dart';

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
            padding: EdgeInsets.only(right: 8.w),
            child: PopupMenuButton<String>(
              color: AppColors.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.w),
              ),
              icon: Icon(
                Icons.more_vert,
                color: AppColors.secondaryText,
                size: 24.w,
              ),
              onSelected: (value) {
                if (value == 'clear_all') {
                  showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      title: "Clear All Notifications?",
                      content:
                          "This action will permanently delete all your notifications. Are you sure you want to proceed?",
                      confirmText: "Clear All",
                      confirmColor: AppColors.primaryGreen,
                      onConfirm: () {
                        context
                            .read<NotificationCubit>()
                            .clearAllNotifications();
                      },
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'clear_all',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_sweep_outlined,
                        color: AppColors.primaryGreen,
                        size: 20.w,
                      ),
                      12.W,
                      Text(
                        "Clear All",
                        style: TextStyles.caption1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    Lottie.asset(
                      AppImages.notificationJson,
                      width: 250.w,
                      height: 250.w,
                      fit: BoxFit.contain,
                    ),
                    16.H,
                    Text(
                      "No notifications yet",
                      style: TextStyles.body.copyWith(
                        color: AppColors.accentGrey,
                      ),
                    ),
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
                      var cubit = context.read<NotificationCubit>();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                          key: ValueKey(notification),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(20),
                                onPressed: (context) {
                                  cubit.deleteNotification(notification);
                                },
                                backgroundColor: AppColors.errorColor,
                                foregroundColor: AppColors.backgroundColor,
                                icon: Icons.delete_outline_rounded,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: NotificationCard(
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
                          ),
                        ),
                      );
                    }),
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
