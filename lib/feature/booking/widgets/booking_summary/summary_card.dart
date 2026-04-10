import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/format_time.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/booking/widgets/booking_summary/booking_info_box.dart';
import 'package:smart_sport_club/feature/booking/widgets/booking_summary/coach_row.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key, required this.bookingModel});
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACADEMY & SPORT',
            style: TextStyle(
              color: AppColors.primaryGreen,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.w,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            bookingModel.academyName,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Training Session',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 14.sp),
          ),
          Divider(height: 28.h, color: Colors.white24),
          CoachRow(coach: bookingModel.coach),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BookingInfoBox(
                icon: Icons.calendar_today,
                title: DateFormat('EEE, d MMM').format(bookingModel.date),
                subtitle: 'DATE',
              ),
              BookingInfoBox(
                icon: Icons.schedule,
                title: formatTime(bookingModel.session.startTime),
                subtitle: 'TIME',
              ),
              const BookingInfoBox(
                icon: Icons.hourglass_empty,
                title: '1 Hour',
                subtitle: 'DURATION',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
