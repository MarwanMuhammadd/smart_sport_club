import 'package:smart_sport_club/core/constant/app_images.dart';
import 'academy_model.dart';

class MockAcademiesData {
  static final List<Academy> academies = [
    const Academy(
      id: '1',
      name: 'Tennis Academy',
      category: 'TENNIS',
      isActive: true,
      trainerCount: 12,
      imageUrl: AppImages.tennisAcademy,
    ),
    const Academy(
      id: '2',
      name: 'Football Academy',
      category: 'FOOTBALL',
      isActive: false,
      trainerCount: 15,
      imageUrl: AppImages.footballAcademy,
    ),
    const Academy(
      id: '3',
      name: 'Swimming Academy',
      category: 'SWIMMING',
      isActive: true,
      trainerCount: 9,
      imageUrl: AppImages.swimmingAcademy,
    ),
  ];
}
