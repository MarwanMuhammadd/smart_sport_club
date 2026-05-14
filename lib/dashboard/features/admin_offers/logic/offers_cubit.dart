import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/offer_model.dart';
import '../data/repos/offers_repository.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepository _offersRepository;
  StreamSubscription? _offersSubscription;

  OffersCubit(this._offersRepository) : super(OffersInitial());

  void loadOffers() {
    emit(OffersLoading());
    _offersSubscription?.cancel();
    _offersSubscription = _offersRepository.getOffers().listen(
      (offers) {
        emit(OffersLoaded(offers: offers, filteredOffers: offers));
      },
      onError: (error) {
        emit(OffersError(error.toString()));
      },
    );
  }

  void searchOffers(String query) {
    if (state is OffersLoaded) {
      final currentState = state as OffersLoaded;
      if (query.isEmpty) {
        emit(OffersLoaded(
          offers: currentState.offers,
          filteredOffers: currentState.offers,
          searchQuery: '',
        ));
      } else {
        final filtered = currentState.offers
            .where((offer) =>
                offer.title.toLowerCase().contains(query.toLowerCase()) ||
                offer.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(OffersLoaded(
          offers: currentState.offers,
          filteredOffers: filtered,
          searchQuery: query,
        ));
      }
    }
  }

  Future<void> addOffer(OfferModel offer) async {
    try {
      await _offersRepository.createOffer(offer);
      // We don't necessarily need to emit a state here if we are using a Stream listener,
      // but we could emit a success state for UI feedback if needed.
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> deleteOffer(String offerId) async {
    try {
      await _offersRepository.deleteOffer(offerId);
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _offersSubscription?.cancel();
    return super.close();
  }
}
