import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';
import 'package:smart_sport_club/feature/sports/data/sports_data.dart';
import 'package:smart_sport_club/feature/sports/widgets/available_slots.dart';
import 'package:smart_sport_club/feature/sports/widgets/header_part.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.sportsData});
  final SportsData sportsData;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.sportsData.name,
          style: TextStyles.title.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader("Select Coach"),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 120,
                      child: CircleImage(coachData: coachData),
                    ),

                    _buildHeader("Select Date"),
                    10.H,

                    SizedBox(
                      height: 100,
                      child: DatePicker(
                        DateTime.now(),
                        initialSelectedDate: selectedDate,
                        selectionColor: AppColors.primaryGreen,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildHeader("Available Slots"),
                    const SizedBox(height: 4),

                    AvailableSlots(
                      sessions: getSessionsForDay(selectedDate)
                          .where(
                            (session) =>
                                session.startTime.year == selectedDate.year &&
                                session.startTime.month == selectedDate.month &&
                                session.startTime.day == selectedDate.day,
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets مساعدة لتقليل تكرار الكود ---
  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(title, style: TextStyles.title),
    );
  }
}
