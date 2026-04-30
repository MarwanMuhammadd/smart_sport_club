import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/build_management_grid.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/build_over_view_title.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/build_statcards_grid.dart';

import '../widgets/dashboard_layout.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

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
        title: const Text("Dashboard"),
      ), // Reuse th,
      body: ListView(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 48),
        children: [
          // Overview Section
          BuildOverViewTitle(),
          const SizedBox(height: 24),

          // Stat Cards Grid
          const BuildStatcardsGrid(),
          const SizedBox(height: 48),

          // Management Hub Section
          const Text(
            'Management Hub',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 24,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
              height: 1.30,
              letterSpacing: -0.24,
            ),
          ),
          const SizedBox(height: 24),

          // Management Cards Grid
          BuildManagementGrid(),
        ],
      ),
    );
  }
}
