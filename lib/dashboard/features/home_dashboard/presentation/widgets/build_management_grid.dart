import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/data/dashboard_static_data.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/management_hub_card.dart';

class BuildManagementGrid extends StatelessWidget {
  const BuildManagementGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 700) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1200) {
          crossAxisCount = 2;
        }

        double spacing = 24;
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: DashboardStaticData.managementCards.map((card) {
            return SizedBox(
              width: itemWidth,
              child: ManagementHubCard(
                title: card['title'],
                description: card['description'],
                imageUrl: card['imageUrl'],
                icon: card['icon'],
                onViewDetails: () {
                  if (card['title'] == 'Trainers') {
                    context.go(AppRoutes.trainers);
                  } else if (card['title'] == 'Academies') {
                    context.go(AppRoutes.academies);
                  }
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}