import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/goRouter/dashboard_router.dart';
import 'package:smart_sport_club/core/styles/theme.dart';

void main() {
  runApp(const SmartSportDashboard());
}

class SmartSportDashboard extends StatelessWidget {
  const SmartSportDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smart Sport Club Admin',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      routerConfig: DashboardRouter.router,
    );
  }
}
