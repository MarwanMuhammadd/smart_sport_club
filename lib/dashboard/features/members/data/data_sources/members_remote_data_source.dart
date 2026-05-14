import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/member_model.dart';

class MembersRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<MemberModel>> getMembersStream() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MemberModel.fromFirestore(doc))
          .toList();
    });
  }
}
