import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/manager/firebase_manager.dart';
import 'package:control/models/notification_center_option.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/repository/notification_center_repository.dart';
import 'package:equatable/equatable.dart';

part 'notification_center_event.dart';
part 'notification_center_state.dart';

class NotificationCenterBloc
    extends Bloc<NotificationCenterEvent, NotificationCenterState> {
  NotificationCenterBloc(this.repository)
      : super(const NotificationCenterState()) {
    on<NotificationOptionChangeRequest>(_mapChangeOptionRequestToState);
    on<NotificationInitOptionRequest>(_mapInitOptionsRequestToState);
  }

  final NotificationCenterRepository repository;

  void _mapInitOptionsRequestToState(
    NotificationInitOptionRequest event,
    Emitter<NotificationCenterState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    final options = user?.notificationsOptions
      ?..sort((a, b) => a.id.compareTo(b.id));
    emit(state.copyWith(
      status: NotificationCenterStatus.init,
      options: options,
    ));
  }

  void _mapChangeOptionRequestToState(
    NotificationOptionChangeRequest event,
    Emitter<NotificationCenterState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    var options = state.options;
    if (event.option != null) {
      options?.removeWhere((e) => e.key == event.option?.key);
      options?.add(event.option!);
    }
    _suscribeTopicUpdate(event.option);
    emit(state.copyWith(status: NotificationCenterStatus.loading));
    options?.sort((a, b) => a.id.compareTo(b.id));
    await repository.updateUser(user, options);
    emit(state.copyWith(
      status: NotificationCenterStatus.init,
      options: options,
    ));
  }

  void _suscribeTopicUpdate(NotificationCenterOption? topic) async {
    FirebaseManager.topic(topic);
  }
}
