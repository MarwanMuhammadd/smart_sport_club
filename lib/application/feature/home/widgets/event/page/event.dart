import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import '../data/event_model.dart';

class LiveEventCard extends StatefulWidget {
  final EventModel event;

  const LiveEventCard({super.key, required this.event});

  @override
  State<LiveEventCard> createState() => _LiveEventCardState();
}

class _LiveEventCardState extends State<LiveEventCard> {
  late Timer _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Update timer if the event data changes (e.g., eventDate)
  @override
  void didUpdateWidget(LiveEventCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.event.eventDate != widget.event.eventDate) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      final now = DateTime.now();
      setState(() {
        _duration = widget.event.eventDate.difference(now);
      });

      if (_duration.isNegative) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String days = _duration.inDays.toString().padLeft(2, '0');
    String hours = (_duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');

    return Column(
      children: [
        Text(
          'Monthly Highlight',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1D1F24),
            borderRadius: BorderRadius.circular(25.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.w)),
                child: Image.network(
                  widget.event.imageUrl,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180.h,
                    color: Colors.grey[800],
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      widget.event.description,
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 25.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Countdown Timer
                        Row(
                          children: [
                            _buildTimeColumn(days, 'DAYS'),
                            _buildDivider(),
                            _buildTimeColumn(hours, 'HRS'),
                            _buildDivider(),
                            _buildTimeColumn(minutes, 'MIN'),
                          ],
                        ),

                        // Join Button
                        ElevatedButton(
                          onPressed: () => print("Joined: ${widget.event.title}"),
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
        ),
      ],
    );
  }

  Widget _buildTimeColumn(String value, String unit) {
    return Column(
      children: [
        Text(
          _duration.isNegative ? "00" : value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          unit,
          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
        ),
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
