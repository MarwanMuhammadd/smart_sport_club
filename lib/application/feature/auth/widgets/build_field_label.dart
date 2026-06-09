import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class BuildFieldLabel extends StatelessWidget {
  final String label;
  final Color? color;

  const BuildFieldLabel({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: TextStyles.caption1.copyWith(
          color: color ?? Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
