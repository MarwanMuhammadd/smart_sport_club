import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/sports_data.dart';

class SuccessActionButtons extends StatelessWidget {
  const SuccessActionButtons({super.key, required this.bookingModel});
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGreen,
            foregroundColor: Colors.black,
            minimumSize: Size(double.infinity, 56.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.w),
            ),
          ),
          onPressed: () {
            context.push(AppRoutes.myBookings);
          },
          child: Text(
            'Go to My Bookings',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12.h),
        TextButton.icon(
          onPressed: () {
            // Find the sports data matching the academy name
            final data = sportData.firstWhere(
              (element) => element.name == bookingModel.academyName,
              orElse: () => sportData.first,
            );
            context.go(AppRoutes.booking, extra: data);
          },
          icon: Icon(Icons.arrow_back, size: 18.w),
          label: Text('Back to Academy', style: TextStyle(fontSize: 14.sp)),
          style: TextButton.styleFrom(foregroundColor: AppColors.secondaryText),
        ),
      ],
    );
  }
}
