import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_model.dart';

abstract class EventsRepository {
  Stream<List<EventModel>> subscribeToEvents();
}

class EventsRepositoryImpl implements EventsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<EventModel>> subscribeToEvents() {
    // Note: We use a simple query here to avoid the need for manual composite indexes in Firestore.
    // We'll filter for 'isActive' in the mapping logic instead.
    return _firestore
        .collection('offers')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromMap(doc.data(), doc.id))
          .where((event) => event.isActive) // Filter locally to avoid Index requirements
          .toList();
    });
  }
}
