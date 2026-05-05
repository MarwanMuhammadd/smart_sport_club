class Academy {
  final String id;
  final String name;
  final String category;
  final bool isActive;
  final int trainerCount;
  final String imageUrl;

  const Academy({
    required this.id,
    required this.name,
    required this.category,
    required this.isActive,
    required this.trainerCount,
    required this.imageUrl,
  });

  Academy copyWith({
    String? id,
    String? name,
    String? category,
    bool? isActive,
    int? trainerCount,
    String? imageUrl,
  }) {
    return Academy(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      trainerCount: trainerCount ?? this.trainerCount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
