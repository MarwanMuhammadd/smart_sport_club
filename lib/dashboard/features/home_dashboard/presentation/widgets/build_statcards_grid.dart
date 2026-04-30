import 'package:flutter/material.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/data/dashboard_static_data.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/stat_card.dart';

class BuildStatcardsGrid extends StatelessWidget {
  const BuildStatcardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 4;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1;
        } else if (constraints.maxWidth < 1100) {
          crossAxisCount = 2;
        }

        double spacing = 24;
        double itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
            crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: DashboardStaticData.statCards.map((stat) {
            return SizedBox(
              width: itemWidth,
              child: StatCard(
                title: stat['title'],
                value: stat['value'],
                icon: stat['icon'],
                isPositive: stat['isPositive'],
              ),
            );
          }).toList(),
        );
      },
    );;
  }
}