class AcademyModel {
  final int? id;
  final String? name;
  final String? description;
  final String? location;
  final String? imageUrl;
  final String? type;
  final bool? isFeatured;
  final bool? isNew;
  final bool? isActive;
  final int? displayOrder;
  final int? sportId;

  AcademyModel({
    this.id,
    this.name,
    this.description = '',
    this.location = 'unknown',
    this.imageUrl,
    this.type,
    this.isFeatured = false,
    this.isNew = false,
    this.isActive = true,
    this.displayOrder = 0,
    this.sportId = 1,
  });

  factory AcademyModel.fromJson(Map<String, dynamic> json) {
    return AcademyModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? 'unknown',
      imageUrl: json['imageUrl'] as String?,
      type: json['type'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      displayOrder: json['displayOrder'] as int? ?? 0,
      sportId: json['sportId'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'description': description ?? '',
        'location': location ?? 'unknown',
        'imageUrl': imageUrl,
        'type': type,
        'isFeatured': isFeatured ?? false,
        'isNew': isNew ?? false,
        'isActive': isActive ?? true,
        'displayOrder': displayOrder ?? 0,
        'sportId': sportId ?? 1,
      };
}
