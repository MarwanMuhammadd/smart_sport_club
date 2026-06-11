import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/application/feature/sports/logic/sports_cubit.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/coach_selection_section.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/date_selection_section.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/slots_selection_section.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.academy});
  final Academy academy;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) {
        final now = DateTime.now();
        // Pre-load sessions for the current day
        context.read<SportsCubit>().loadSessionsForDay(now);
        return BookingCubit()..selectDate(now);
      },
      child: BlocListener<BookingCubit, BookingState>(
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
        child: Scaffold(
          backgroundColor: isDark ? AppColors.darkBackground : null,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: isDark ? AppColors.darkTextPrimary : Colors.black, size: 24.w),
              onPressed: () {
                context.go('${AppRoutes.mainApp}?tab=2');
              },
            ),
            title: Text(
              academy.name,
              style: TextStyles.title.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 20.sp,
                color: isDark ? AppColors.darkTextPrimary : AppColors.primaryColor,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const RangeMaintainingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CoachSelectionSection(
                          academyId: academy.academyId,
                          category: academy.category,
                        ),
                        20.H,
                        const DateSelectionSection(),
                        20.H,
                        SlotsSelectionSection(academy: academy),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
