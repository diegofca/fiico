import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/modules/notifications/repository/notifications_repository.dart';
import 'package:equatable/equatable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationState> {
  NotificationsBloc(this.repository) : super(const NotificationState()) {
    on<NotificationssFetchRequest>(
      _mapNotificationsToState,
    );
  }

  final NotificationsRepository repository;

  void _mapNotificationsToState(
    NotificationssFetchRequest event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(
      status: NotificationsStatus.waiting,
      notifications: repository.notifications(event.uID),
    ));
  }
}
