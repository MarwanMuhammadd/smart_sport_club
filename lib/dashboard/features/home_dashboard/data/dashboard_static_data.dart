import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';

class DashboardStaticData {
  // Sidebar Items
  static const List<Map<String, dynamic>> sidebarItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_outlined,
      'route': AppRoutes.homeDashboard,
    },
    {
      'title': 'Trainers',
      'icon': Icons.people_outline,
      'route': AppRoutes.trainers,
    },
    {
      'title': 'Academies',
      'icon': Icons.account_balance_outlined,
      'route': AppRoutes.academies,
    },
    {
      'title': 'Members',
      'icon': Icons.person_outline,
      'route': AppRoutes.members,
    },
    {
      'title': 'Offers',
      'icon': Icons.local_offer_outlined,
      'route': AppRoutes.offers,
    },
    {
      'title': 'Requests',
      'icon': Icons.notifications_none_outlined,
      'route': AppRoutes.requests,
    },
  ];

  

  // Management Hub Cards
  static const List<Map<String, dynamic>> managementCards = [
    {
      'title': 'Trainers',
      'description':
          'Manage certifications, schedules, and performance ratings of 800+ trainers.',
      'imageUrl': AppImages.coachOne,
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Academies',
      'description':
          'Oversee regional sports branches, facility status, and local management teams.',
      'imageUrl': AppImages.footballAcademy,
      'icon': Icons.business,
    },
    {
      'title': 'Members',
      'description':
          'Handle subscriptions, user engagement data, and membership support tickets.',
      'imageUrl': AppImages.membership,
      'icon': Icons.people,
    },
    {
      'title': 'Offers',
      'description':
          'Create and monitor promotional campaigns, early bird discounts and seasonal deals.',
      'imageUrl': AppImages.carouselTwo,
      'icon': Icons.local_offer,
    },
  ];

  // Stats
  static const List<Map<String, dynamic>> statCards = [
    {
      'title': 'Total Members',
      'value': '12,482',

      'icon': Icons.people,
      'isPositive': true,
    },
    {
      'title': 'Total Trainers',
      'value': '842',
      'icon': Icons.fitness_center,
      'isPositive': true,
    },
    {
      'title': 'Academies',
      'value': '156',
      'icon': Icons.store,
      'isPositive': true,
    },
    {
      'title': 'Active Offers',
      'value': '24',
      'icon': Icons.local_offer,
      'isPositive': true,
    },
  ];
}
