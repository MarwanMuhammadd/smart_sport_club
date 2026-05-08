import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';

class MockAcademiesData {
  static final List<Academy> academies = [
    const Academy(
      academyId:  '1',
      name: 'Tennis Academy',
      category: 'TENNIS',
      isActive: true,
      imageUrl: AppImages.tennisAcademy,
    ),
    const Academy(
      academyId: '2',
      name: 'Football Academy',
      category: 'FOOTBALL',
      isActive: false,
      imageUrl: AppImages.footballAcademy,
    ),
    const Academy(
      academyId: '3',
      name: 'Swimming Academy',
      category: 'SWIMMING',
      isActive: true,
      imageUrl: AppImages.swimmingAcademy,
    ),
  ];
}
