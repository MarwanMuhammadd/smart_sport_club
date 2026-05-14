import '../presentation/widgets/offer_model.dart';

class OffersData {
  static final List<Offer> dummyOffers = [
    Offer(
      id: '1',
      title: 'Summer Training Discount',
      description: 'Get 20% off on all tennis training sessions this summer. Valid for group sessions only.',
      imageUrl: 'https://placehold.co/100x100',
      expiryDate: 'Aug 31, 2024',
      usedCount: 142,
      isActive: true,
    ),
    Offer(
      id: '2',
      title: 'New Member Welcome',
      description: 'First month 50% discount for all new academy enrollments. Join the community today!',
      imageUrl: 'https://placehold.co/100x100',
      expiryDate: 'Dec 31, 2024',
      usedCount: 85,
      isActive: true,
    ),
    Offer(
      id: '3',
      title: 'Family Package Offer',
      description: 'Register 3 or more family members and get a flat 15% discount on total fees.',
      imageUrl: 'https://placehold.co/100x100',
      expiryDate: 'Oct 15, 2024',
      usedCount: 42,
      isActive: false,
    ),
  ];
}
