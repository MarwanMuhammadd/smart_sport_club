import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';
import 'package:smart_sport_club/feature/sports/data/sports_data.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_cubit.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_state.dart';
import 'package:smart_sport_club/feature/sports/widgets/available_slots.dart';
import 'package:smart_sport_club/feature/sports/widgets/header_part.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.sportsData});
  final SportsData sportsData;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<SportsCubit>().loadSessionsForDay(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit()..selectDate(_selectedDate),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingCapacityExceeded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is BookingReadyToConfirm) {
            context.push(AppRoutes.bookingSummary, extra: state.bookingModel);
          }
        },
        builder: (context, state) {
          CoachData? selectedCoach;
          SessionModel? selectedSession;

          if (state is BookingSelectionUpdated) {
            selectedCoach = state.selectedCoach;
            selectedSession = state.selectedSession;
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.w),
                onPressed: () {
                  context.go('${AppRoutes.mainApp}?tab=2');
                },
              ),
              title: Text(
                widget.sportsData.name,
                style: TextStyles.title.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader("Select Coach"),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 120.h,
                            child: CircleImage(
                              coachData: coachData,
                              selectedCoachId: selectedCoach?.id,
                              onCoachSelected: (coach) {
                                context.read<BookingCubit>().selectCoach(coach);
                              },
                            ),
                          ),
                          _buildHeader("Select Date"),
                          10.H,
                          SizedBox(
                            height: 100.h,
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: _selectedDate,
                              selectionColor: AppColors.primaryGreen,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                setState(() => _selectedDate = date);
                                context.read<BookingCubit>().selectDate(date);
                                context.read<SportsCubit>().loadSessionsForDay(
                                  date,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildHeader("Available Slots"),
                          SizedBox(height: 4.h),
                          BlocBuilder<SportsCubit, SportsState>(
                            builder: (context, sportsState) {
                              final sessions = context
                                  .read<SportsCubit>()
                                  .getSessionsForDate(_selectedDate);

                              return AvailableSlots(
                                sessions: sessions,
                                selectedSession: selectedSession,
                                onSessionSelected: (session) {
                                  context.read<BookingCubit>().selectSession(
                                    session,
                                  );
                                },
                                onBookNow: () {
                                  context.read<BookingCubit>().bookNow(
                                    widget.sportsData.name,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Widgets مساعدة لتقليل تكرار الكود ---
  Widget _buildHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Text(title, style: TextStyles.title.copyWith(fontSize: 18.sp)),
    );
  }
}
