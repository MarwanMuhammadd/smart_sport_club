import 'package:flutter/material.dart';

class ServicesData {
  final String title;
  final IconData icon;

  ServicesData({required this.title, required this.icon});
}

final List<ServicesData> servicesItemData = [
  ServicesData(title: "Club Restaurant", icon: Icons.restaurant),
  ServicesData(title: 'Upcoming Parties', icon: Icons.celebration),
  ServicesData(title: "Café", icon: Icons.local_cafe),
  ServicesData(title: "Kids Activities", icon: Icons.child_care),
];
