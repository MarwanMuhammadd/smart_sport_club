class Offer {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String expiryDate;
  final int usedCount;
  final bool isActive;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.expiryDate,
    required this.usedCount,
    this.isActive = true,
  });
}
