import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/application/feature/chatbot/logic/chatbot_cubit.dart';
import 'package:smart_sport_club/application/feature/chatbot/pages/chatbot_page.dart';
import 'package:smart_sport_club/application/feature/home/pages/home_page.dart';
import 'package:smart_sport_club/application/feature/notification/logic/notification_cubit.dart';
import 'package:smart_sport_club/application/feature/notification/logic/notification_state.dart';
import 'package:smart_sport_club/application/feature/notification/pages/notification_page.dart';
import 'package:smart_sport_club/application/feature/profile/pages/profile_page.dart';
import 'package:smart_sport_club/application/feature/sports/pages/sport_screen.dart';

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
    const HomeScreen(),
    const NotificationPage(),
    const SportsScreen(),
    BlocProvider(
      create: (context) => ChatbotCubit(),
      child: const ChatbotPage(),
    ),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        iconSize: 24.w,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentIndex = value;
            log("$currentIndex");
          });
          if (value == 1) {
            context.read<NotificationCubit>().markAllAsRead();
          }
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            label: "notification",
            icon: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                final unreadCount = context
                    .read<NotificationCubit>()
                    .unreadCount;
                return Badge(
                  label: Text('$unreadCount'),
                  isLabelVisible: unreadCount > 0,
                  child: const Icon(Icons.notifications),
                );
              },
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: "Sports",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "AI Chat",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
