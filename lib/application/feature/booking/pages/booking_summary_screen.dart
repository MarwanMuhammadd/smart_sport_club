import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/booking_policy.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/payment_method_section.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/price_section.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/summary_action_buttons.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/summary_card.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({super.key, required this.bookingModel});
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.w),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Booking Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SummaryCard(bookingModel: bookingModel),
              SizedBox(height: 24.h),
              const BookingPolicy(),
              SizedBox(height: 24.h),
              const PaymentMethodSection(),
              SizedBox(height: 24.h),
              const PriceSection(),
              SizedBox(height: 28.h),
              SummaryActionButtons(bookingModel: bookingModel),
            ],
          ),
        ),
      ),
    );
  }
}
