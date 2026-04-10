import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';


class HeaderPart extends StatelessWidget {
  const HeaderPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.w),
          topRight: Radius.circular(12.w),
        ),
        gradient: const LinearGradient(
          colors: [Color(0xff06100B), Color(0xff0A1A12)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    
      child: Center(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(35.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.05),
                borderRadius: BorderRadius.circular(70.w),
                border: Border.all(color: Colors.white12, width: 1.w),
              ),
              child: Icon(
                Icons.lock_reset,
                size: 80.w,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
