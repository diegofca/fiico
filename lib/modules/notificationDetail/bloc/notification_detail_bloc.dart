import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/modules/notifications/repository/notifications_repository.dart';
import 'package:equatable/equatable.dart';

part 'notification_detail_event.dart';
part 'notification_detail_state.dart';

class NotificationDetailBloc
    extends Bloc<NotificationDetailEvent, NotificationDetailState> {
  NotificationDetailBloc(this.repository)
      : super(const NotificationDetailState()) {
    on<NotificationsReadedRequest>(_mapNotificationReadedToState);
    on<NotificationGetBudgetRequest>(_mapNotificationGetBudgetToState);
  }

  final NotificationsRepository repository;

  void _mapNotificationReadedToState(
    NotificationsReadedRequest event,
    Emitter<NotificationDetailState> emit,
  ) async {
    await repository.readNotification(event.notification);
    emit(state.copyWith(
      status: NotificationDetailStatus.waiting,
    ));
  }

  void _mapNotificationGetBudgetToState(
    NotificationGetBudgetRequest event,
    Emitter<NotificationDetailState> emit,
  ) async {
    final budget = await repository.getBudget(event.budgetID);
    emit(state.copyWith(
      status: NotificationDetailStatus.waiting,
      budget: budget,
    ));
  }
}
