import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/logic/dashboard_stats_cubit.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/logic/dashboard_stats_state.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/stat_card.dart';

class BuildStatcardsGrid extends StatelessWidget {
  const BuildStatcardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardStatsCubit, DashboardStatsState>(
      builder: (context, state) {
        if (state is DashboardStatsLoading || state is DashboardStatsInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is DashboardStatsError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(
                'Failed to load stats: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final stats = state as DashboardStatsLoaded;

        final List<Map<String, dynamic>> statCards = [
          {
            'title': 'Total Members',
            'value': stats.totalMembers.toString(),
            'icon': Icons.people,
            'isPositive': true,
          },
          {
            'title': 'Total Trainers',
            'value': stats.totalTrainers.toString(),
            'icon': Icons.fitness_center,
            'isPositive': true,
          },
          {
            'title': 'Academies',
            'value': stats.totalAcademies.toString(),
            'icon': Icons.store,
            'isPositive': true,
          },
          {
            'title': 'Active Offers',
            'value': stats.activeOffers.toString(),
            'icon': Icons.local_offer,
            'isPositive': true,
          },
        ];

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 4;
            if (constraints.maxWidth < 600) {
              crossAxisCount = 1;
            } else if (constraints.maxWidth < 1100) {
              crossAxisCount = 2;
            }

            final double spacing = 24;
            final double itemWidth =
                (constraints.maxWidth - (crossAxisCount - 1) * spacing) /
                crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: statCards.map((stat) {
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
        );
      },
    );
  }
}