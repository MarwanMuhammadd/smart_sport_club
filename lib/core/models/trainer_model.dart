import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TrainerModel extends Equatable {
  final String id;
  final String name;
  final String academyId;
  final String academyName;
  final String imageUrl;

  const TrainerModel({
    required this.id,
    required this.name,
    required this.academyId,
    required this.academyName,
    required this.imageUrl,
  });

  /// Always uses doc.id (Firestore auto-generated) as the unique identifier.
  factory TrainerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TrainerModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      academyId: data['academyId'] as String? ?? '',
      academyName: data['academyName'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'academyId': academyId,
      'academyName': academyName,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  @override
  List<Object?> get props => [id, name, academyId, academyName, imageUrl];
}
