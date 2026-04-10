import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/feature/home/pages/home_page.dart';
import 'package:smart_sport_club/feature/sports/pages/sport_screen.dart';
import 'package:smart_sport_club/feature/profile/pages/profile_page.dart';
import 'package:smart_sport_club/feature/notification/pages/notification_page.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  List<Widget> screen = [
    HomeScreen(),
    NotificationPage(),
    SportsScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        iconSize: 24.w,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            label: "notification",
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
