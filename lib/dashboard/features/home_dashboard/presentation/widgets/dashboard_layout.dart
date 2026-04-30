import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'sidebar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget body;
  final Widget? header;

  const DashboardLayout({
    super.key,
    required this.body,
    this.header,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool _isCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _toggleSidebar() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.dashboardBackground,
      drawer: isDesktop
          ? null
          : Drawer(
              width: 260,
              child: Sidebar(
                isCollapsed: false,
                onToggle: () => Navigator.pop(context),
              ),
            ),
      body: Row(
        children: [
          // Sidebar for Desktop
          if (isDesktop)
            Sidebar(
              isCollapsed: _isCollapsed,
              onToggle: _toggleSidebar,
            ),
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Header (if provided)
                if (widget.header != null) 
                  Builder(
                    builder: (headerContext) => widget.header!,
                  ),
                
                // Content
                Expanded(child: widget.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

