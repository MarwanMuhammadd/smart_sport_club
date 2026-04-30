import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';

class BuilderHeader extends StatelessWidget {
  const BuilderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bool isDesktop = Responsive.isDesktop(context);
        return Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 16),
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            border: Border(
              bottom: BorderSide(width: 1, color: AppColors.headerBorder),
            ),
          ),
          child: Row(
            children: [
              if (!isDesktop)
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.primaryColor),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              if (!isDesktop) const SizedBox(width: 8),
              if (!isDesktop)
                const Text(
                  'SmartClub',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
