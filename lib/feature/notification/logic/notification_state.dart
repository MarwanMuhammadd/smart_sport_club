import 'package:smart_sport_club/feature/notification/data/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  NotificationLoaded(this.notifications);
}
