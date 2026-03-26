import 'package:smart_sport_club/core/constant/app_images.dart';

class CoachData {
  final String name;
  final String imagePath;
  final String id;

  CoachData({required this.name, required this.imagePath, required this.id});
}

final List<CoachData> coachData = [
  CoachData(name: "Mike", imagePath: AppImages.coachOne, id: "1"),
  CoachData(name: "Sarah", imagePath: AppImages.coachFour, id: "2"),
  CoachData(name: "Jordan", imagePath: AppImages.coachTwo, id: "3"),
  CoachData(name: "Alex", imagePath: AppImages.coachThree, id: "4"),
  CoachData(name: "Mike", imagePath: AppImages.coachOne, id: "5"),
  CoachData(name: "Sarah", imagePath: AppImages.coachFour, id: "6"),
  CoachData(name: "Jordan", imagePath: AppImages.coachTwo, id: "7"),
  CoachData(name: "Alex", imagePath: AppImages.coachThree, id: "8"),
];
