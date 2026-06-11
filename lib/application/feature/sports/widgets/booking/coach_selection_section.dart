import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart';
import 'package:smart_sport_club/application/feature/sports/data/repo/academy_repo.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_cubit.dart';
import 'package:smart_sport_club/application/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/booking/section_header.dart';
import 'package:smart_sport_club/application/feature/sports/widgets/header_part.dart';

class CoachSelectionSection extends StatelessWidget {
  const CoachSelectionSection({
    super.key,
    required this.academyId,
    required this.category,
  });

  final String academyId;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Select Coach"),
        SizedBox(height: 16.h),
        SizedBox(
          height: 120.h,
          child: FutureBuilder<({List<AcademyModel>? response, String? error})>(
            future: AcademyRepo.getAcademies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || snapshot.data?.error != null) {
                return const Center(child: Text('Error loading trainers'));
              }

              final academies = snapshot.data?.response ?? [];
              final currentAcademy = academies.firstWhere(
                (a) => a.id?.toString() == academyId,
                orElse: () => AcademyModel(),
              );

              final trainers = currentAcademy.trainers;

              final coaches = trainers
                  .where((t) => t is Map)
                  .map((t) => TrainerModel(
                        id: t['id']?.toString() ?? '',
                        name: t['fullName']?.toString() ?? '',
                        academyId: academyId,
                        academyName: t['specialization']?.toString() ?? '',
                        imageUrl: t['imageUrl']?.toString() ?? '',
                      ))
                  .toList();

              if (coaches.isEmpty) {
                return const Center(child: Text('No trainers available'));
              }

              return BlocBuilder<BookingCubit, BookingState>(
                buildWhen: (previous, current) =>
                    current is BookingInitial ||
                    current is BookingSelectionUpdated,
                builder: (context, state) {
                  final selectedCoachId =
                      state is BookingSelectionUpdated
                          ? state.selectedCoach?.id
                          : null;

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
