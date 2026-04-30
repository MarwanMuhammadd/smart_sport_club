import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class SildebarItems extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final bool isSmall;
  final bool isCollapsed;
  const SildebarItems({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.isSmall = false,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isCollapsed ? 0 : 24,
          vertical: isSmall ? 12 : 16,
        ),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                border: const Border(
                  left: BorderSide(
                    width: 4,
                    color: AppColors.primaryGreen,
                  ),
                ),
              )
            : null,
        child: Row(
          mainAxisAlignment: isCollapsed
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primaryGreen : AppColors.accentGrey,
              size: 22,
            ),
            if (!isCollapsed) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.accentGrey,
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
