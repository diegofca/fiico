part of 'notifications_bloc.dart';

enum NotificationsStatus {
  waiting,
}

class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationsStatus.waiting,
    this.notifications,
  });

  final NotificationsStatus status;
  final Stream<List<FiicoNotification>>? notifications;

  @override
  List<Object> get props => [status, notifications ?? []];

  NotificationState copyWith({
    NotificationsStatus? status,
    Stream<List<FiicoNotification>>? notifications,
    int? budgetSelected,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }
}
