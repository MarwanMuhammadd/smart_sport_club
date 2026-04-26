import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/feature/booking/widgets/my_bookings/booking_card.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.w),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(Icons.more_vert, size: 24.w),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Search
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search your bookings',
                hintStyle: const TextStyle(color: AppColors.secondaryText),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.secondaryText,
                  size: 20.w,
                ),
                filled: true,
                fillColor: AppColors.blackColor,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.w),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          /// List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                /// Upcoming
                const BookingCard(
                  title: 'Football Academy',
                  coach: 'Coach Sarah Jenkins',
                  date: 'Mon, 24 Oct • 05:00 PM',
                  imageUrl: AppImages.footballAcademy,
                  footer: '1 Hour • \$50.00',
                ),
              ],
            ),
          ),
        ],
      ),

      /// Bottom Navigation
    );
  }
}
