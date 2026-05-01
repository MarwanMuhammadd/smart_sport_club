import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/sports/data/coach_data.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.coachData,
    this.onCoachSelected,
    this.selectedCoachId,
  });

  final List<CoachData> coachData;
  final Function(CoachData)? onCoachSelected;
  final String? selectedCoachId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: coachData.length,
        itemBuilder: (context, index) {
          final coach = coachData[index];
          bool isSelected = selectedCoachId == coach.id;
          return Container(
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (onCoachSelected != null) {
                      onCoachSelected!(coach);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : Colors.transparent,
                        width: 2.w,
                      ),
                    ),
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryGreen.withOpacity(0.1), // Light background for SVGs
                      ),
                      child: ClipOval(
                        child: coach.imagePath.isEmpty
                            ? Container(
                                width: 60.w,
                                height: 60.w,
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, color: Colors.grey),
                              )
                            : coach.imagePath.startsWith('http')
                                ? Image.network(
                                    coach.imagePath,
                                    fit: BoxFit.cover,
                                    width: 60.w,
                                    height: 60.w,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 60.w,
                                        height: 60.w,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.person, color: Colors.grey),
                                      );
                                    },
                                  )
                                : coach.imagePath.endsWith('.svg')
                                    ? Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: SvgPicture.asset(
                                          coach.imagePath,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : Image.asset(
                                        coach.imagePath,
                                        fit: BoxFit.cover,
                                        width: 60.w,
                                        height: 60.w,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 60.w,
                                            height: 60.w,
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.person, color: Colors.grey),
                                          );
                                        },
                                      ),
                      ),
                    ),
                  ),
                ),
                Text(
                  coach.name,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.W,
              ],
            ),
          );
        },
      ),
    );
  }
}
