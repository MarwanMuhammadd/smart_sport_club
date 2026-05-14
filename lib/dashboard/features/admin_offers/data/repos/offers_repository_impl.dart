import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/offer_model.dart';
import 'offers_repository.dart';

class OffersRepositoryImpl implements OffersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionPath = 'offers';

  @override
  Future<void> createOffer(OfferModel offer) async {
    try {
      final docRef = _firestore.collection(_collectionPath).doc();
      final offerWithId = offer.copyWith(id: docRef.id);
      await docRef.set(offerWithId.toMap());
    } catch (e) {
      throw Exception('Failed to create offer: $e');
    }
  }

  @override
  Stream<List<OfferModel>> getOffers() {
    return _firestore
        .collection(_collectionPath)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => OfferModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    try {
      await _firestore.collection(_collectionPath).doc(offerId).delete();
    } catch (e) {
      throw Exception('Failed to delete offer: $e');
    }
  }

  @override
  Future<void> updateOffer(OfferModel offer) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(offer.id)
          .update(offer.toMap());
    } catch (e) {
      throw Exception('Failed to update offer: $e');
    }
  }
}
