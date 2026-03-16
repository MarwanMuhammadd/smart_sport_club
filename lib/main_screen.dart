import 'package:flutter/material.dart';
import 'package:smart_sport_club/feature/home/pages/home_page.dart';
import 'package:smart_sport_club/feature/sports/pages/sport_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  List<Widget> screen = [
    HomeScreen(),
    Center(child: Text("data")),
    SportsScreen(),
    Center(child: Text("data")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",

            // activeIcon: SvgActiveIcon(
            //   path: AppImages.homeSvg,
            //   color: AppColors.primaryGreen,
            // ),
          ),
          BottomNavigationBarItem(
            label: "notification",
            icon: Icon(Icons.notifications),
            // activeIcon: SvgActiveIcon(
            //   path: AppImages.bellSvg,
            //   color: AppColors.primaryColor,
            // ),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",

            // activeIcon: SvgActiveIcon(
            //   path: AppImages.personSvg,
            //   color: AppColors.primaryColor,
            // ),
          ),
        ],
      ),
    );
  }
}
