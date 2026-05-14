import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String type; // discount | event | seasonal | academy-specific
  final DateTime? endDate;
  final DateTime createdAt;
  final bool isActive;
  final int usedCount;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
    this.endDate,
    required this.createdAt,
    this.isActive = true,
    this.usedCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'type': type,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
      'usedCount': usedCount,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OfferModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      type: map['type'] ?? 'discount',
      endDate: map['endDate'] != null ? (map['endDate'] as Timestamp).toDate() : null,
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate() : DateTime.now(),
      isActive: map['isActive'] ?? true,
      usedCount: map['usedCount'] ?? 0,
    );
  }

  OfferModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? type,
    DateTime? endDate,
    DateTime? createdAt,
    bool? isActive,
    int? usedCount,
  }) {
    return OfferModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      usedCount: usedCount ?? this.usedCount,
    );
  }
}
