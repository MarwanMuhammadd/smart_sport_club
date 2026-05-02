import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TrainerModel extends Equatable {
  final String id;
  final String name;
  final String academy;
  final String imageUrl;

  const TrainerModel({
    required this.id,
    required this.name,
    required this.academy,
    required this.imageUrl,
  });

  /// Always uses doc.id (Firestore auto-generated) as the unique identifier.
  /// Never trust the user-entered 'id' field — it is not guaranteed to be unique.
  factory TrainerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TrainerModel(
      id: doc.id, // ← Firestore document ID: always unique
      name: data['name'] as String? ?? '',
      academy: data['academy'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, academy, imageUrl];
}
