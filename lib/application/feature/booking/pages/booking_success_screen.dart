import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_success/booking_details_card.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_success/success_action_buttons.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_success/success_header.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key, required this.bookingModel});
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              const SuccessHeader(),
              SizedBox(height: 24.h),
              Text(
                'Booking Confirmed',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your training session has been successfully reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 40.h),
              BookingDetailsCard(bookingModel: bookingModel),
              SizedBox(height: 30.h),
              Text(
                'You can manage or cancel your booking from My Bookings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontStyle: FontStyle.italic,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 40.h),
              SuccessActionButtons(bookingModel: bookingModel),
            ],
          ),
        ),
      ),
    );
  }
}
