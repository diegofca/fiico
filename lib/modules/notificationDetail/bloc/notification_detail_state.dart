part of 'notification_detail_bloc.dart';

enum NotificationDetailStatus {
  waiting,
}

class NotificationDetailState extends Equatable {
  const NotificationDetailState({
    this.status = NotificationDetailStatus.waiting,
    this.notifications,
    this.budget,
  });

  final NotificationDetailStatus status;
  final Stream<List<FiicoNotification>>? notifications;
  final Budget? budget;

  bool get loadBudget => budget != null;

  @override
  List<Object?> get props => [status, notifications, budget];

  NotificationDetailState copyWith({
    NotificationDetailStatus? status,
    Stream<List<FiicoNotification>>? notifications,
    Budget? budget,
  }) {
    return NotificationDetailState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      budget: budget,
    );
  }
}
