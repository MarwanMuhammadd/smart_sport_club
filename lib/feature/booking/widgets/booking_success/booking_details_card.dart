import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/format_time.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/booking/widgets/booking_success/booking_detail_column.dart';
import 'package:smart_sport_club/feature/booking/widgets/booking_success/booking_detail_row.dart';

class BookingDetailsCard extends StatelessWidget {
  const BookingDetailsCard({super.key, required this.bookingModel});
  final BookingModel bookingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BOOKING ID',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.secondaryText,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '#SC-${bookingModel.session.id.toUpperCase()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Text(
                  'CONFIRMED',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          BookingDetailRow(title: 'Academy', value: bookingModel.academyName),
          BookingDetailRow(title: 'Coach', value: bookingModel.coach.name),
          Divider(color: Colors.white12, height: 20.h),
          Row(
            children: [
              Expanded(
                child: BookingDetailColumn(
                  title: 'Date',
                  value: DateFormat('EEE, d MMM').format(bookingModel.date),
                ),
              ),
              Expanded(
                child: BookingDetailColumn(
                  title: 'Time',
                  value: formatTime(bookingModel.session.startTime),
                  isAlignEnd: true,
                ),
              ),
            ],
          ),
          Divider(color: Colors.white12, height: 20.h),
          Row(
            children: [
              const Expanded(
                child: BookingDetailColumn(title: 'Duration', value: '1 Hour'),
              ),
              Expanded(
                child: BookingDetailColumn(
                  title: 'Current Capacity',
                  value:
                      '${bookingModel.session.currentBookings + 1}/${bookingModel.session.maxCapacity}',
                  isHighlighted: true,
                  isAlignEnd: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
