import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/booking/logic/booking_state.dart';
import 'package:smart_sport_club/feature/sports/data/coach_data.dart';
import 'package:smart_sport_club/feature/sports/data/slots_data.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  void selectCoach(CoachData coach) {
    if (state is BookingSelectionUpdated) {
      emit((state as BookingSelectionUpdated).copyWith(selectedCoach: coach));
    } else {
      emit(BookingSelectionUpdated(selectedCoach: coach, selectedDate: DateTime.now()));
    }
  }

  void selectDate(DateTime date) {
    if (state is BookingSelectionUpdated) {
      emit((state as BookingSelectionUpdated).copyWith(selectedDate: date, selectedSession: null));
    } else {
      emit(BookingSelectionUpdated(selectedDate: date));
    }
  }

  void selectSession(SessionModel session) {
    if (state is BookingSelectionUpdated) {
      emit((state as BookingSelectionUpdated).copyWith(selectedSession: session));
    } else {
      emit(BookingSelectionUpdated(selectedSession: session));
    }
  }

  void bookNow(String academyName) {
    if (state is BookingSelectionUpdated) {
      final selection = state as BookingSelectionUpdated;
      
      if (selection.selectedCoach == null) {
        emit(const BookingCapacityExceeded("Please select a coach first"));
        return;
      }
      if (selection.selectedDate == null) {
        emit(const BookingCapacityExceeded("Please select a date first"));
        return;
      }
      if (selection.selectedSession == null) {
        emit(const BookingCapacityExceeded("Please select a session first"));
        return;
      }

      // Capacity Logic: 20 sessions max
      if (selection.selectedSession!.currentBookings >= selection.selectedSession!.maxCapacity) {
        emit(const BookingCapacityExceeded("You cannot book because the session capacity has been reached (Max 20)"));
      } else {
        final booking = BookingModel(
          academyName: academyName,
          coach: selection.selectedCoach!,
          date: selection.selectedDate!,
          session: selection.selectedSession!,
        );
        emit(BookingReadyToConfirm(booking));
      }
    }
  }
}
