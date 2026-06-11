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
  final String? sportName;
  final int? trainersCount;
  final int? membersCount;
  final List<dynamic> trainers;

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
    this.sportName,
    this.trainersCount = 0,
    this.membersCount = 0,
    this.trainers = const [],
  });

  factory AcademyModel.fromJson(Map<String, dynamic> json) {
    return AcademyModel(
      id: _parseInt(json['id']),
      name: json['name']?.toString(),
      description: json['description']?.toString() ?? '',
      location: json['location']?.toString() ?? 'unknown',
      imageUrl: json['imageUrl']?.toString(),
      type: json['type']?.toString(),
      isFeatured: _parseBool(json['isFeatured']) ?? false,
      isNew: _parseBool(json['isNew']) ?? false,
      isActive: _parseBool(json['isActive']) ?? true,
      displayOrder: _parseInt(json['displayOrder']) ?? 0,
      sportId: _parseInt(json['sportId']) ?? 1,
      sportName: json['sportName']?.toString(),
      trainersCount: _parseInt(json['trainersCount']) ?? 0,
      membersCount: _parseInt(json['membersCount']) ?? 0,
      trainers: json['trainers'] is List ? json['trainers'] as List : const [],
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

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  static bool? _parseBool(dynamic value) {
    if (value is bool) return value;
    final text = value?.toString().toLowerCase();
    if (text == 'true') return true;
    if (text == 'false') return false;
    return null;
  }
}
