import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/models/trainer_model.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    super.key,
    required this.coachData,
    this.onCoachSelected,
    this.selectedCoachId,
  });

  final List<TrainerModel> coachData;
  final Function(TrainerModel)? onCoachSelected;
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
          final bool isSelected = selectedCoachId == coach.id;
          return Container(
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                InkWell(
                  onTap: () => onCoachSelected?.call(coach),
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
                        color: AppColors.primaryGreen.withOpacity(0.1),
                      ),
                      child: ClipOval(
                        child: coach.imageUrl.isEmpty
                            ? Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.person,
                                    color: Colors.grey),
                              )
                            : Image.network(
                                coach.imageUrl,
                                fit: BoxFit.cover,
                                width: 60.w,
                                height: 60.w,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.person,
                                      color: Colors.grey),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
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
