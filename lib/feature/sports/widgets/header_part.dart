import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/feature/sports/data/coach_data.dart';

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
                    child: CircleAvatar(
                      radius: 30.w,
                      backgroundImage: AssetImage(
                        coach.imagePath,
                      ),
                    ),
                  ),
                ),
                Text(
                  coach.name,
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
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
