import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class TrainersStaticData {
  static const List<Map<String, dynamic>> trainers = [
    {
      'name': 'Marcus Sterling',
      'role': 'Tennis Coach',
      'image': AppImages.coachOneTennis,
      'tagColor': AppColors.tennisTag,
      'tagTextColor': AppColors.tennisText,
      'borderColor': AppColors.tennisBorder,
    },
    {
      'name': 'Elena Rodriguez',
      'role': 'Fitness Coach',
      'image': AppImages.coachTwoTennis,
      'tagColor': AppColors.fitnessTag,
      'tagTextColor': AppColors.fitnessText,
      'borderColor': AppColors.fitnessBorder,
    },
    {
      'name': 'Julian Vane',
      'role': 'Football Coach',
      'image': AppImages.coachThreeTennis,
      'tagColor': AppColors.footballTag,
      'tagTextColor': AppColors.footballText,
      'borderColor': AppColors.footballBorder,
    },
    {
      'name': 'Sarah Jenkins',
      'role': 'Yoga Instructor',
      'image': AppImages.coachFourTennis,
      'tagColor': AppColors.yogaTag,
      'tagTextColor': AppColors.yogaText,
      'borderColor': AppColors.yogaBorder,
    },
  ];
}
