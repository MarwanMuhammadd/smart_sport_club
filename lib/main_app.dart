import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_sport_club/application/feature/notification/logic/notification_cubit.dart';
import 'package:smart_sport_club/application/feature/sports/logic/sports_cubit.dart';
import 'package:smart_sport_club/core/goRouter/app_routers.dart';
import 'package:smart_sport_club/core/local/shared_pref.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';
import 'package:smart_sport_club/core/styles/theme.dart';
import 'package:smart_sport_club/core/theme/theme_cubit.dart';
import 'package:smart_sport_club/core/theme/theme_repo.dart';
import 'package:smart_sport_club/core/theme/theme_state.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smart_sport_club/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPref.init();
  DioProvider.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(ThemeRepo())..loadSavedTheme(),
        ),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(
          create: (context) => SportsCubit(context.read<NotificationCubit>()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouters.router,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
