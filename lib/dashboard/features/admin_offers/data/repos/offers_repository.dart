import '../models/offer_model.dart';

abstract class OffersRepository {
  Future<void> createOffer(OfferModel offer);
  Stream<List<OfferModel>> getOffers();
  Future<void> deleteOffer(String offerId);
  Future<void> updateOffer(OfferModel offer);
}
