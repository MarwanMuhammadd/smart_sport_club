import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainer_card.dart';

/// Responsive grid that displays a list of trainer cards.
class TrainersGrid extends StatelessWidget {
  final List<TrainerModel> trainers;
  final void Function(TrainerModel) onDelete;

  const TrainersGrid({
    super.key,
    required this.trainers,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1000) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth < 1300) {
          crossAxisCount = 3;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            mainAxisExtent: 320,
          ),
          itemCount: trainers.length,
          itemBuilder: (context, index) {
            final trainer = trainers[index];
            return TrainerCard(
              trainerId: trainer.id,
              name: trainer.name,
              academy: trainer.academy,
              imageUrl: trainer.imageUrl,
              onDelete: () => onDelete(trainer),
            );
          },
        );
      },
    );
  }
}
