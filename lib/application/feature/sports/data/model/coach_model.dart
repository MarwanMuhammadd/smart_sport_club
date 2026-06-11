class CoachRequest {
  final String fullName;
  final String specialization;
  final String imageUrl;
  final String bio;
  final int experienceYears;
  final String phoneNumber;
  final String email;
  final int academyId;

  const CoachRequest({
    required this.fullName,
    required this.specialization,
    required this.imageUrl,
    required this.bio,
    required this.experienceYears,
    required this.phoneNumber,
    required this.email,
    required this.academyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'bio': bio,
      'experienceYears': experienceYears,
      'phoneNumber': phoneNumber,
      'email': email,
      'academyId': academyId,
    };
  }
}

class CoachResponse {
  final int id;
  final String fullName;
  final String specialization;
  final String imageUrl;
  final String bio;
  final int experienceYears;
  final double rating;
  final String phoneNumber;
  final String email;
  final bool isActive;
  final int? academyId;
  final List<int> academyIds;

  const CoachResponse({
    required this.id,
    required this.fullName,
    required this.specialization,
    required this.imageUrl,
    required this.bio,
    required this.experienceYears,
    required this.rating,
    required this.phoneNumber,
    required this.email,
    required this.isActive,
    this.academyId,
    this.academyIds = const [],
  });

  factory CoachResponse.fromJson(Map<String, dynamic> json) {
    return CoachResponse(
      id: json['id'] as int? ?? 0,
      fullName: json['fullName'] as String? ?? '',
      specialization: json['specialization'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      experienceYears: json['experienceYears'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      academyId: json['academyId'] as int?,
      academyIds: (json['academies'] as List?)
              ?.where((e) => e is Map && e['id'] != null)
              .map((e) => (e as Map)['id'] as int)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'specialization': specialization,
      'imageUrl': imageUrl,
      'bio': bio,
      'experienceYears': experienceYears,
      'rating': rating,
      'phoneNumber': phoneNumber,
      'email': email,
      'isActive': isActive,
      if (academyId != null) 'academyId': academyId,
      'academies': academyIds.map((id) => {'id': id}).toList(),
    };
  }
}
