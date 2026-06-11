import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/goRouter/dashboard_router.dart';
import 'package:smart_sport_club/core/styles/theme.dart';
import 'package:smart_sport_club/core/theme/theme_cubit.dart';
import 'package:smart_sport_club/core/theme/theme_repo.dart';
import 'package:smart_sport_club/core/theme/theme_state.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smart_sport_club/firebase_options.dart';

import 'package:smart_sport_club/core/local/shared_pref.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPref.init();
  DioProvider.init();
  runApp(const SmartSportDashboard());
}

class SmartSportDashboard extends StatelessWidget {
  const SmartSportDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(ThemeRepo())..loadSavedTheme(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Smart Sport Club Admin',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: DashboardRouter.router,
          );
        },
      ),
    );
  }
}
//navigator.of(context).DashboardRouter.
