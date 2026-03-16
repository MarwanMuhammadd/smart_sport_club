import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/auth/pages/welcome_screen.dart';
import 'package:smart_sport_club/feature/splash/widgets/build_footer.dart';
import 'package:smart_sport_club/feature/splash/widgets/build_header_sectiom.dart';

class SmartSportsScreen extends StatefulWidget {
  const SmartSportsScreen({super.key});

  @override
  State<SmartSportsScreen> createState() => _SmartSportsScreenState();
}

class _SmartSportsScreenState extends State<SmartSportsScreen>
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
            setState(() {}); // إعادة بناء الوجت لتحديث القيمة
          });

    // بدء الأنيميشن
    _controller.forward().then((value) {
      // هنا تقدر تحط الكود اللي هينقلك للصفحة اللي بعد الـ Splash
      Navigations.pushReplacement(context, WelcomeScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // تنظيف الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // الدوائر الخلفية (نفس الكود السابق)
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white10, width: 1),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),

                // ... (نفس قسم الـ Icon والـ Title والـ Description بدون تغيير) ...
                buildHeaderSection(),

                const Spacer(flex: 2),

                // Progress Section (المعدل ليناسب الأنيميشن)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Syncing stadium data...',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        // عرض النسبة المئوية المتحركة
                        Text(
                          '${(_progressAnimation.value * 100).toInt()}%',
                          style: TextStyles.caption1.copyWith(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progressAnimation.value, // القيمة المتحركة
                        minHeight: 6,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Footer (نفس الكود السابق)
                buildFooter(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دوال مساعدة لتبسيط الكود (Refactoring)
}
