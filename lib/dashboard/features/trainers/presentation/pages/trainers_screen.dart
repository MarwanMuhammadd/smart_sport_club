import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/dashboard_layout.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/delete_confirm_sheet.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_grid.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_header.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_stats.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  String searchQuery = '';

  Future<void> _confirmDelete(TrainerModel trainer) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => DeleteConfirmSheet(trainer: trainer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('trainers').snapshots(),
        builder: (context, snapshot) {
          final allTrainers = (snapshot.data?.docs ?? [])
              .map((doc) => TrainerModel.fromFirestore(doc))
              .toList();

          final filteredTrainers = searchQuery.isEmpty
              ? allTrainers
              : allTrainers
                  .where((t) => t.name
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();

          return ListView(
            padding: EdgeInsets.all(isMobile ? 16 : 48),
            children: [
              TrainersHeader(
                onSearchChanged: (value) =>
                    setState(() => searchQuery = value),
              ),
              const SizedBox(height: 32),
              TrainersStats(totalTrainers: allTrainers.length),
              const SizedBox(height: 32),
              if (snapshot.connectionState == ConnectionState.waiting &&
                  allTrainers.isEmpty)
                const Center(child: CircularProgressIndicator())
              else if (filteredTrainers.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Text(
                      'No trainers found.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                TrainersGrid(
                  trainers: filteredTrainers,
                  onDelete: _confirmDelete,
                ),
            ],
          );
        },
      ),
    );
  }
}
