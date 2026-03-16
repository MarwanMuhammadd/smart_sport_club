import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/theme.dart';
import 'package:smart_sport_club/feature/splash/pages/splash_screen.dart';
import 'package:smart_sport_club/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      // builder: (context, child) {
      //   return SafeArea(
      //     bottom: Platform.isAndroid ? true : false,
      //     top: true,
      //     child: child ?? Container(),
      //   );
      // },
      home: SmartSportsScreen(),
    );
  }
}
