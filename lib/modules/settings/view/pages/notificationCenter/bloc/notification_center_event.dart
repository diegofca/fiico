part of 'notification_center_bloc.dart';

abstract class NotificationCenterEvent extends Equatable {
  const NotificationCenterEvent();
}

class NotificationInitOptionRequest extends NotificationCenterEvent {
  const NotificationInitOptionRequest();

  @override
  List<Object?> get props => [];
}

class NotificationOptionChangeRequest extends NotificationCenterEvent {
  const NotificationOptionChangeRequest({required this.option});

  final NotificationCenterOption? option;

  @override
  List<Object?> get props => [option];
}
