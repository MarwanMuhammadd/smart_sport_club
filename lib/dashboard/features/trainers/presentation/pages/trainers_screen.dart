import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/dashboard_layout.dart';
import 'package:smart_sport_club/dashboard/features/trainers/data/trainers_static_data.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainer_card.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_header.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_stats.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    // Filter trainers based on search query
    final filteredTrainers = TrainersStaticData.trainers.where((trainer) {
      final name = trainer['name'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query);
    }).toList();

    return DashboardLayout(
      header: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text("Trainers"),
      ),
      body: ListView(
        padding: EdgeInsets.all(isMobile ? 16 : 48),
        children: [
          TrainersHeader(
            onSearchChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 32),
          TrainersStats(totalTrainers: TrainersStaticData.trainers.length),
          const SizedBox(height: 32),
          LayoutBuilder(
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
                itemCount: filteredTrainers.length,
                itemBuilder: (context, index) {
                  final trainer = filteredTrainers[index];
                  return TrainerCard(
                    name: trainer['name'],
                    role: trainer['role'],
                    imageUrl: trainer['image'],
                    tagColor: trainer['tagColor'],
                    tagTextColor: trainer['tagTextColor'],
                    avatarBorderColor: trainer['borderColor'],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
