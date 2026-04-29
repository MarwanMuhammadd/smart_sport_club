import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/format_time.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';
import 'package:smart_sport_club/feature/booking/pages/booking_summary_screen.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';

class AvailableSlots extends StatelessWidget {
  const AvailableSlots({
    super.key,
    required this.sessions,
    this.onSessionSelected,
    this.selectedSession,
    this.onBookNow,
  });

  final List<SessionModel> sessions;
  final Function(SessionModel)? onSessionSelected;
  final SessionModel? selectedSession;
  final VoidCallback? onBookNow;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        bool isSelected = selectedSession == session;
        return InkWell(
          onTap: () {
            if (onSessionSelected != null) {
              onSessionSelected!(session);
            }
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
              side: BorderSide(
                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                width: 2.w,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.title,
                          style: TextStyles.body.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18.w,
                              color: AppColors.primaryGreen,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "${formatTime(session.startTime)} - ${formatTime(session.endTime)}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Capacity: ${session.currentBookings}/${session.maxCapacity}",
                          style: TextStyle(
                            color:
                                session.currentBookings >= session.maxCapacity
                                ? Colors.red
                                : Colors.grey[600],
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log("--- DEBUG BOOKING ---");
                      log("Session: ${session.title}");
                      
                      bool isFull = session.currentBookings >= session.maxCapacity;
                      log("Current Capacity: ${session.currentBookings}/${session.maxCapacity}");
                      log("Is Session Full: $isFull");

                      if (!isFull) {
                        log("LOGIC: Booking triggered successfully");
                        if (onSessionSelected != null) {
                          onSessionSelected!(session);
                        }
                        if (onBookNow != null) {
                          onBookNow!();
                        }
                      } else {
                        log("LOGIC: Booking BLOCKED because session is full");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
