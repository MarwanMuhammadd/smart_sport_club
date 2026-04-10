import 'package:equatable/equatable.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingSelectionUpdated extends BookingState {
  final CoachData? selectedCoach;
  final DateTime? selectedDate;
  final SessionModel? selectedSession;

  const BookingSelectionUpdated({
    this.selectedCoach,
    this.selectedDate,
    this.selectedSession,
  });

  @override
  List<Object?> get props => [selectedCoach, selectedDate, selectedSession];

  BookingSelectionUpdated copyWith({
    CoachData? selectedCoach,
    DateTime? selectedDate,
    SessionModel? selectedSession,
  }) {
    return BookingSelectionUpdated(
      selectedCoach: selectedCoach ?? this.selectedCoach,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSession: selectedSession ?? this.selectedSession,
    );
  }
}

class BookingCapacityExceeded extends BookingState {
  final String message;

  const BookingCapacityExceeded(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingReadyToConfirm extends BookingState {
  final BookingModel bookingModel;

  const BookingReadyToConfirm(this.bookingModel);

  @override
  List<Object?> get props => [bookingModel];
}
