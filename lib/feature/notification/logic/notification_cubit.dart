import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/feature/notification/data/notification_model.dart';
import 'package:smart_sport_club/feature/notification/logic/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationLoaded(const []));

  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification); // Add to top for reverse chronological
    _emitLoaded();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    _emitLoaded();
  }

  void _emitLoaded() {
    // Re-sort just in case, though insert(0) handles most cases for this specific flow
    _notifications.sort((a, b) => b.time.compareTo(a.time));
    emit(NotificationLoaded(List.from(_notifications)));
  }
}
