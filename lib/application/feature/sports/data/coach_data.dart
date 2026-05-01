import 'package:smart_sport_club/core/constant/app_images.dart';

class CoachData {
  final String name;
  final String imagePath;
  final String id;

  CoachData({required this.name, required this.imagePath, required this.id});
}

final List<CoachData> tennisCoaches = [
  CoachData(name: "Mike", imagePath: AppImages.coachOneTennis, id: "t1"),
  CoachData(name: "Sarah", imagePath: AppImages.coachTwoTennis, id: "t2"),
  CoachData(name: "Jordan", imagePath: AppImages.coachThreeTennis, id: "t3"),
  CoachData(name: "Alex", imagePath: AppImages.coachFourTennis, id: "t4"),
];

final List<CoachData> footballCoaches = [
  CoachData(name: "John", imagePath: AppImages.coachOneFootball, id: "f1"),
  CoachData(name: "David", imagePath: AppImages.coachTwoFootball, id: "f2"),
  CoachData(name: "Robert", imagePath: AppImages.coachThreeFootball, id: "f3"),
  CoachData(name: "James", imagePath: AppImages.coachFourFootball, id: "f4"),
];

final List<CoachData> swimmingCoaches = [
  CoachData(name: "Emily", imagePath: AppImages.coachOneSwimming, id: "s1"),
  CoachData(name: "Jessica", imagePath: AppImages.coachTwoSwimming, id: "s2"),
  CoachData(name: "Sophia", imagePath: AppImages.coachThreeSwimming, id: "s3"),
  CoachData(name: "Olivia", imagePath: AppImages.coachFourSwimming, id: "s4"),
];

//final List<CoachData> coachData = tennisCoaches; // Default for backward compatibility if needed
