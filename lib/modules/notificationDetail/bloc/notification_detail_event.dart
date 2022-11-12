part of 'notification_detail_bloc.dart';

abstract class NotificationDetailEvent extends Equatable {
  const NotificationDetailEvent();
}

class NotificationsReadedRequest extends NotificationDetailEvent {
  const NotificationsReadedRequest({required this.notification});

  final FiicoNotification? notification;

  @override
  List<Object?> get props => [notification];
}

class NotificationGetBudgetRequest extends NotificationDetailEvent {
  const NotificationGetBudgetRequest({required this.budgetID});

  final String? budgetID;

  @override
  List<Object?> get props => [budgetID];
}
