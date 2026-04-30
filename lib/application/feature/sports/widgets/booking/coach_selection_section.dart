import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/application/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/section_header.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/header_part.dart';

class CoachSelectionSection extends StatelessWidget {
  const CoachSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Select Coach"),
        SizedBox(height: 16.h),
        SizedBox(
          height: 120.h,
          child: BlocBuilder<BookingCubit, BookingState>(
            buildWhen: (previous, current) =>
                current is BookingInitial || current is BookingSelectionUpdated,
            builder: (context, state) {
              String? selectedCoachId;
              if (state is BookingSelectionUpdated) {
                selectedCoachId = state.selectedCoach?.id;
              }

              return CircleImage(
                coachData: coachData,
                selectedCoachId: selectedCoachId,
                onCoachSelected: (coach) {
                  context.read<BookingCubit>().selectCoach(coach);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
