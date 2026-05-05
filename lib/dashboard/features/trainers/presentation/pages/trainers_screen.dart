import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/dashboard_layout.dart';
import 'package:smart_sport_club/dashboard/features/trainers/logic/trainers_cubit.dart';
import 'package:smart_sport_club/dashboard/features/trainers/logic/trainers_state.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/delete_confirm_sheet.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_grid.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_header.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainers_stats.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, TrainerModel trainer) async {
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
      body: BlocBuilder<TrainersCubit, TrainersState>(
        builder: (context, state) {
          List<TrainerModel> allTrainers = [];
          List<TrainerModel> filteredTrainers = [];
          String searchQuery = '';
          bool isLoading = state is TrainersLoading;
    
          if (state is TrainersLoaded) {
            allTrainers = state.allTrainers;
            filteredTrainers = state.filteredTrainers;
            searchQuery = state.searchQuery;
          }
    
          return ListView(
            padding: EdgeInsets.all(isMobile ? 16 : 48),
            children: [
              TrainersHeader(
                onSearchChanged: (value) =>
                    context.read<TrainersCubit>().searchTrainers(value),
              ),
              const SizedBox(height: 32),
              TrainersStats(totalTrainers: allTrainers.length),
              const SizedBox(height: 32),
              
              if (isLoading && allTrainers.isEmpty)
                const Center(child: CircularProgressIndicator(color: AppColors.primaryGreen))
              else if (state is TrainersError)
                Center(child: Text(state.message))
              else if (filteredTrainers.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        const Icon(Icons.search_off, size: 48, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.isEmpty 
                              ? 'No trainers found.' 
                              : 'No results for "$searchQuery"',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                TrainersGrid(
                  trainers: filteredTrainers,
                  onDelete: (trainer) => _confirmDelete(context, trainer),
                ),
            ],
          );
        },
      ),
    );
  }
}
