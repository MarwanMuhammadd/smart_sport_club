import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/data/dashboard_static_data.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/sildebar_items.dart';

class Sidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const Sidebar({super.key, this.isCollapsed = false, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString();
    final bool isDesktop = Responsive.isDesktop(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 80 : 260,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        border: Border(
          right: BorderSide(width: 1, color: AppColors.sidebarBorder),
        ),
      ),
      child: Column(
        children: [
          // Logo and Toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (!isCollapsed)
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SmartClub',
                          style: TextStyle(
                            color: AppColors.primaryGreen,
                            fontSize: 20,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Admin Terminal',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 10,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    isCollapsed ? Icons.menu : Icons.menu_open,
                    color: AppColors.accentGrey,
                  ),
                  onPressed: onToggle,
                ),
              ],
            ),
          ),

          // Navigation Links
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: DashboardStaticData.sidebarItems.length,
              itemBuilder: (context, index) {
                final item = DashboardStaticData.sidebarItems[index];
                final String itemRoute = item['route'];
                final bool isActive = currentRoute == itemRoute;

                return SildebarItems(
                  title: item['title'],
                  icon: item['icon'],
                  isActive: isActive,
                  onTap: () {
                    if (!isActive) {
                      context.go(itemRoute);
                    }
                    // Close drawer on mobile/tablet after navigation
                    if (!isDesktop) {
                      Navigator.pop(context);
                    }
                  },
                  isCollapsed: isCollapsed,
                );
              },
            ),
          ),

          // Footer Links
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
