import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/application/feature/sports/logic/sports_cubit.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/section_header.dart';

class DateSelectionSection extends StatelessWidget {
  const DateSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Select Date"),
        10.H,
        SizedBox(
          height: 100.h,
          child: BlocBuilder<BookingCubit, BookingState>(
            buildWhen: (previous, current) =>
                current is BookingInitial || current is BookingSelectionUpdated,
            builder: (context, state) {
              DateTime selectedDate = DateTime.now();
              if (state is BookingSelectionUpdated) {
                selectedDate = state.selectedDate ?? DateTime.now();
              }

              return DatePicker(
                DateTime.now(),
                initialSelectedDate: selectedDate,
                selectionColor: AppColors.primaryGreen,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  context.read<BookingCubit>().selectDate(date);
                  context.read<SportsCubit>().loadSessionsForDay(date);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
