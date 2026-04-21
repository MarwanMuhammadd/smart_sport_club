import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_cubit.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_state.dart';
import 'package:smart_sport_club/feature/sports/widgets/available_slots.dart';
import 'package:smart_sport_club/feature/sports/widgets/booking/section_header.dart';

class SlotsSelectionSection extends StatelessWidget {
  final String academyName;

  const SlotsSelectionSection({super.key, required this.academyName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Available Slots"),
        SizedBox(height: 4.h),
        BlocBuilder<BookingCubit, BookingState>(
          buildWhen: (previous, current) =>
              current is BookingInitial || current is BookingSelectionUpdated,
          builder: (context, bookingState) {
            DateTime selectedDate = DateTime.now();
            SessionModel? selectedSession;

            if (bookingState is BookingSelectionUpdated) {
              selectedDate = bookingState.selectedDate ?? DateTime.now();
              selectedSession = bookingState.selectedSession;
            }

            return BlocBuilder<SportsCubit, SportsState>(
              builder: (context, sportsState) {
                final sessions = context
                    .read<SportsCubit>()
                    .getSessionsForDate(selectedDate);

                return AvailableSlots(
                  sessions: sessions,
                  selectedSession: selectedSession,
                  onSessionSelected: (session) {
                    context.read<BookingCubit>().selectSession(session);
                  },
                  onBookNow: () {
                    context.read<BookingCubit>().bookNow(academyName);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
