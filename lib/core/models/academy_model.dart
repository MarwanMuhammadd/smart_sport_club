class Academy {
  final String academyId;
  final String name;
  final String category;
  final String description;
  final bool isActive;
  final String imageUrl;

  const Academy({
    required this.academyId,
    required this.name,
    required this.category,
    this.description = '',
    required this.isActive,
    required this.imageUrl,
  });

  factory Academy.fromMap(Map<String, dynamic> map, String id) {
    return Academy(
      academyId: id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      isActive: map['isActive'] ?? true,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'academyId': academyId,
      'name': name,
      'category': category,
      'description': description,
      'isActive': isActive,
      'imageUrl': imageUrl,
    };
  }

  Academy copyWith({
    String? academyId,
    String? name,
    String? category,
    String? description,
    bool? isActive,
    String? imageUrl,
  }) {
    return Academy(
      academyId: academyId ?? this.academyId,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
