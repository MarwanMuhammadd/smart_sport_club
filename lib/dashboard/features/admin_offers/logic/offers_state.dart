import 'package:equatable/equatable.dart';
import '../data/models/offer_model.dart';

abstract class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object?> get props => [];
}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final List<OfferModel> offers;
  final List<OfferModel> filteredOffers;
  final String searchQuery;

  const OffersLoaded({
    required this.offers,
    required this.filteredOffers,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [offers, filteredOffers, searchQuery];
}

class OffersError extends OffersState {
  final String message;

  const OffersError(this.message);

  @override
  List<Object?> get props => [message];
}

class OfferCreated extends OffersState {}
