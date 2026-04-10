import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';


class LiveEventCard extends StatefulWidget {
  const LiveEventCard({super.key});

  @override
  State<LiveEventCard> createState() => _LiveEventCardState();
}

class _LiveEventCardState extends State<LiveEventCard> {
  // 1. تحديد ميعاد الحفلة (مثلاً بعد يومين من دلوقتي)
  DateTime eventDate = DateTime.now().add(
    const Duration(days: 12, hours: 8, minutes: 45),
  );
  late Timer _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // 2. ميثود تشغيل التايمر كل ثانية
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      setState(() {
        _duration = eventDate.difference(now);
      });

      // لو الوقت خلص نوقف التايمر
      if (_duration.isNegative) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // مهم جداً عشان ما يستهلكش رامات في الخلفية
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // استخراج القيم من الـ duration
    String days = _duration.inDays.toString().padLeft(2, '0');
    String hours = (_duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F24),
        borderRadius: BorderRadius.circular(25.w),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الجزء اللي فوق (الصورة)
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
            child: Image.asset(
              AppImages.carouselTwo,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Annual Gala Dinner 2024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Grand Ballroom, Smart Club Main Wing',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
                SizedBox(height: 25.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // العداد الشغال
                    Row(
                      children: [
                        _buildTimeColumn(days, 'DAYS'),
                        _buildDivider(),
                        _buildTimeColumn(hours, 'HRS'),
                        _buildDivider(),
                        _buildTimeColumn(minutes, 'MIN'),
                      ],
                    ),

                    // Button
                    ElevatedButton(
                      onPressed: () => print("Joined!"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1ED760),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                      ),
                      child: Text(
                        'Join Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(unit, style: TextStyle(color: Colors.grey, fontSize: 10.sp)),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 25.h,
      width: 1.w,
      color: Colors.white24,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
    );
  }
}
