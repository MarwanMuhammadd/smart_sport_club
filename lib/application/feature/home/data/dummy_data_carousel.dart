import 'package:smart_sport_club/core/constant/app_images.dart';

class DummyDataCarousel {
  final String title;
  final String subtitle;
  final String image;

  DummyDataCarousel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

final List<DummyDataCarousel> banners = [
  DummyDataCarousel(
    title: 'New Tennis Courts Open!',
    subtitle: 'Book your slot now for the weekend tournament.',
    image: AppImages.carouselOne,
  ),
  DummyDataCarousel(
    title: 'Swimming Pool Renovated',
    subtitle: 'Enjoy the new Olympic size pool.',
    image: AppImages.carouselThree,
  ),
  DummyDataCarousel(
    title: 'Gym Membership Offer',
    subtitle: 'Get 30% off this month.',
    image: AppImages.carouselTwo,
  ),
];
