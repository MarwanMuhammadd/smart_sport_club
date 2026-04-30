import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String description;
  final DateTime time;
  final IconData icon;
  final Color color;
  final dynamic extraData;
  bool isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    this.extraData,
    this.isRead = false,
  });
}
