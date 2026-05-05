import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/goRouter/dashboard_router.dart';
import 'package:smart_sport_club/core/styles/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smart_sport_club/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
//navigator.of(context).DashboardRouter.
