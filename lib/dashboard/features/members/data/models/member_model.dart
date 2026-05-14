import 'package:cloud_firestore/cloud_firestore.dart';

class MemberModel {
  final String id;
  final String name;
  final String email;

  MemberModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory MemberModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>? ?? {};
    return MemberModel(
      id: doc.id,
      name: data['name'] ?? 'Unknown Member',
      email: data['email'] ?? 'No email',
    );
  }
}
