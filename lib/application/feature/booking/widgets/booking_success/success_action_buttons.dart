import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';

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
            context.go(AppRoutes.booking, extra: bookingModel.academy);
          },
          child: Text(
            'Back to Academy',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12.h),
        // TextButton.icon(
        //   onPressed: () {
        //     context.go(AppRoutes.booking, extra: bookingModel.academy);
        //   },
        //   icon: Icon(Icons.arrow_back, size: 18.w),
        //   label: Text('Back to Academy', style: TextStyle(fontSize: 14.sp)),
        //   style: TextButton.styleFrom(foregroundColor: AppColors.secondaryText),
        // ),
      ],
    );
  }
}
