import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

Widget buildHeaderSection() {
     return Column(
       children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: EdgeInsets.all(35.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40.w),
                    border: Border.all(color: Colors.white12, width: 1.w),
                  ),
                  child: Icon(Icons.sports_soccer, size: 80.w, color: AppColors.primaryGreen),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(color: AppColors.primaryGreen, shape: BoxShape.circle),
                  child: Icon(Icons.check_circle_outline, size: 20.w, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 40.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(height: 1.2),
              children: [
                TextSpan(text: 'Smart Sports\n', style: TextStyles.hugeHeadLine),
                TextSpan(text: 'Club', style: TextStyles.hugeHeadLine.copyWith(color: AppColors.primaryGreen)),
              ],
            ),
          ),
         
          SizedBox(height: 20.h),
          Text(
            'Elevate your game with professional pitch booking and premium membership.',
            textAlign: TextAlign.center,
            style: TextStyles.body.copyWith(color: AppColors.secondaryText),
          ),
          
       ],
     );
     
  }
