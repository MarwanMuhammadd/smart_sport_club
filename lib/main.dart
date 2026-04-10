import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/goRouter/app_routers.dart';
import 'package:smart_sport_club/core/styles/theme.dart';
import 'package:smart_sport_club/feature/sports/logic/sports_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SportsCubit())],
      child: MaterialApp.router(
        routerConfig: AppRouters.router,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
      ),
    );
  }
}
