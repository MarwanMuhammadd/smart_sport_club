import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/events_repository.dart';
import 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventsRepository _eventsRepository;
  StreamSubscription? _eventsSubscription;

  EventsCubit(this._eventsRepository) : super(EventsInitial());

  void subscribeToEvents() {
    emit(EventsLoading());
    _eventsSubscription?.cancel();
    _eventsSubscription = _eventsRepository.subscribeToEvents().listen(
      (events) {
        emit(EventsLoaded(events));
      },
      onError: (error) {
        emit(EventsError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}
