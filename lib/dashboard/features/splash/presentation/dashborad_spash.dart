import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';

class DashboradSpash extends StatefulWidget {
  const DashboradSpash({super.key});

  @override
  State<DashboradSpash> createState() => _DashboradSpashState();
}

class _DashboradSpashState extends State<DashboradSpash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward().then((value) {
      if (mounted) {
        context.go(AppRoutes.adminLoginScreen);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide;

    // Responsive breakpoint flags
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);

    // Dynamic sizing based on screen category
    final double horizontalPadding = isMobile
        ? size.width * 0.08
        : isTablet
            ? size.width * 0.12
            : size.width * 0.05;

    final double iconSize = isMobile
        ? shortestSide * 0.18
        : isTablet
            ? shortestSide * 0.12
            : 80.0;

    final double iconPadding = isMobile
        ? shortestSide * 0.08
        : isTablet
            ? shortestSide * 0.06
            : 35.0;

    final double iconBorderRadius = isMobile
        ? shortestSide * 0.1
        : isTablet
            ? shortestSide * 0.07
            : 40.0;

    final double badgeSize = isMobile
        ? shortestSide * 0.05
        : isTablet
            ? shortestSide * 0.035
            : 20.0;

    final double verticalGap = isMobile
        ? size.height * 0.03
        : isTablet
            ? size.height * 0.04
            : 40.0;

    final double progressBarHeight = isMobile ? 5.0 : isTablet ? 7.0 : 8.0;
    final double statusFontSize = isMobile ? 11.0 : isTablet ? 13.0 : 14.0;
    final double footerIconSize = isMobile ? 12.0 : 14.0;
    final double footerFontSize = isMobile ? 9.0 : isTablet ? 10.0 : 11.0;
    final double footerLetterSpacing = isMobile ? 1.5 : 2.0;

    // Max content width to prevent stretching on large screens
    final double maxContentWidth = isDesktop ? 500.0 : isTablet ? 480.0 : 400.0;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Decorative background circle
          Positioned(
            top: -size.height * 0.1,
            left: -size.width * 0.05,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: shortestSide * 0.5,
                height: shortestSide * 0.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: size.height * 0.03,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Header Section ──
                      _buildHeaderSection(
                        iconSize: iconSize,
                        iconPadding: iconPadding,
                        iconBorderRadius: iconBorderRadius,
                        badgeSize: badgeSize,
                        isMobile: isMobile,
                        isTablet: isTablet,
                      ),

                      SizedBox(height: verticalGap * 1.4),

                      // ── Progress Section ──
                      _buildProgressSection(
                        statusFontSize: statusFontSize,
                        progressBarHeight: progressBarHeight,
                      ),

                      SizedBox(height: verticalGap * 1.4),

                      // ── Footer Section ──
                      _buildFooter(
                        iconSize: footerIconSize,
                        fontSize: footerFontSize,
                        letterSpacing: footerLetterSpacing,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header: Icon + Title + Subtitle ──
  Widget _buildHeaderSection({
    required double iconSize,
    required double iconPadding,
    required double iconBorderRadius,
    required double badgeSize,
    required bool isMobile,
    required bool isTablet,
  }) {
    final titleStyle = TextStyles.hugeHeadLine.copyWith(
      fontSize: isMobile
          ? 28.0
          : isTablet
              ? 34.0
              : 38.0,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon with badge
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(iconPadding),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(iconBorderRadius),
                  border: Border.all(color: Colors.white12, width: 1),
                ),
                child: Icon(
                  Icons.sports_soccer,
                  size: iconSize,
                  color: AppColors.primaryGreen,
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  padding: EdgeInsets.all(badgeSize * 0.2),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_outline,
                    size: badgeSize,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: isMobile ? 28 : 40),

        // Title
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(height: 1.2),
            children: [
              TextSpan(text: 'Smart Sports\n', style: titleStyle),
              TextSpan(
                text: 'Club',
                style: titleStyle.copyWith(color: AppColors.primaryGreen),
              ),
            ],
          ),
        ),

        SizedBox(height: isMobile ? 14 : 20),

        // Subtitle
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 16),
          child: Text(
            'Elevate your game with professional pitch booking and premium membership.',
            textAlign: TextAlign.center,
            style: TextStyles.body.copyWith(
              color: AppColors.secondaryText,
              fontSize: isMobile ? 13.0 : 15.0,
            ),
          ),
        ),
      ],
    );
  }

  // ── Progress Bar ──
  Widget _buildProgressSection({
    required double statusFontSize,
    required double progressBarHeight,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Syncing stadium data...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: statusFontSize,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(_progressAnimation.value * 100).toInt()}%',
              style: TextStyles.caption1.copyWith(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: statusFontSize,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: _progressAnimation.value,
            minHeight: progressBarHeight,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }

  // ── Footer ──
  Widget _buildFooter({
    required double iconSize,
    required double fontSize,
    required double letterSpacing,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.security, color: AppColors.secondaryText, size: iconSize),
          const SizedBox(width: 8),
          Text(
            'PRO LEAGUE STANDARD',
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
            ),
          ),
        ],
      ),
    );
  }
}
