import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/application/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/section_header.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/header_part.dart';

class CoachSelectionSection extends StatelessWidget {
  const CoachSelectionSection({super.key, required this.academyName});
  final String academyName;

  @override
  Widget build(BuildContext context) {
    // Convert "Tennis Academy" to "Tennis" for DB query
    final String queryName = academyName.replaceAll(' Academy', '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Select Coach"),
        SizedBox(height: 16.h),
        SizedBox(
          height: 120.h,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('trainers')
                .where('academy', isEqualTo: queryName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              List<CoachData> staticCoaches = [];
              if (queryName == 'Tennis') {
                staticCoaches = tennisCoaches;
              } else if (queryName == 'Football') {
                staticCoaches = footballCoaches;
              } else if (queryName == 'Swimming') {
                staticCoaches = swimmingCoaches;
              }

              List<CoachData> dynamicCoaches = [];
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                dynamicCoaches = snapshot.data!.docs
                    .map((doc) => CoachData.fromFirestore(doc))
                    .toList();
              }

              final coaches = [...staticCoaches, ...dynamicCoaches];

              if (coaches.isEmpty) {
                return const Center(child: Text('No trainers available'));
              }

              return BlocBuilder<BookingCubit, BookingState>(
                buildWhen: (previous, current) =>
                    current is BookingInitial || current is BookingSelectionUpdated,
                builder: (context, state) {
                  String? selectedCoachId;
                  if (state is BookingSelectionUpdated) {
                    selectedCoachId = state.selectedCoach?.id;
                  }

                  return CircleImage(
                    coachData: coaches,
                    selectedCoachId: selectedCoachId,
                    onCoachSelected: (coach) {
                      context.read<BookingCubit>().selectCoach(coach);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
