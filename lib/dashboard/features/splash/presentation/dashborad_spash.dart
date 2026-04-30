import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/application/feature/splash/widgets/build_footer.dart';
import 'package:smart_sport_club/application/feature/splash/widgets/build_header_sectiom.dart';

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
        context.go(AppRoutes.adminLogin);
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
    final bool isDesktop = Responsive.isDesktop(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Decorative Background - Using MediaQuery for true responsiveness
          Positioned(
            top: -size.height * 0.1,
            left: -size.width * 0.05,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: size.width * 0.4,
                height: size.width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 50 : 30,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 400),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: buildHeaderSection(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Column(
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
                                      fontSize: isDesktop ? 14 : 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  '${(_progressAnimation.value * 100).toInt()}%',
                                  style: TextStyles.caption1.copyWith(
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isDesktop ? 14 : 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _progressAnimation.value,
                                minHeight: isDesktop ? 8 : 6,
                                backgroundColor: Colors.white10,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: buildFooter(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// دوال مساعدة لتبسيط الكود (Refactoring)
