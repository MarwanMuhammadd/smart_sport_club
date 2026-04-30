import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/application/feature/sports/logic/sports_cubit.dart';

class SummaryActionButtons extends StatelessWidget {
  const SummaryActionButtons({super.key, required this.bookingModel});
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
              borderRadius: BorderRadius.circular(18.w),
            ),
          ),
          onPressed: () {
            // Update capacity in the global SportsCubit
            context.read<SportsCubit>().confirmBooking(bookingModel);

            // Navigate to success screen
            GoRouterHelper(
              context,
            ).pushReplacement(AppRoutes.bookingSuccess, extra: bookingModel);
          },
          child: Text(
            'Confirm Booking',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12.h),
        Center(
          child: TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 16.sp, color: AppColors.primaryGreen),
            ),
          ),
        ),
      ],
    );
  }
}
