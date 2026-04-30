import 'package:smart_sport_club/core/constant/app_images.dart';

class SportsData {
  final String imagePath;
  final String name;

  SportsData({required this.imagePath, required this.name});
}

final List<SportsData> sportData = [
  SportsData(imagePath: AppImages.tennisAcademy, name: "Tennis Academy"),
  SportsData(imagePath: AppImages.swimmingAcademy, name: "Swimming Academy"),
  SportsData(imagePath: AppImages.footballAcademy, name: "Football Academy"),
];
