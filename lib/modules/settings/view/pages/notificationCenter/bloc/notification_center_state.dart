part of 'notification_center_bloc.dart';

enum NotificationCenterStatus { init, loading }

class NotificationCenterState extends Equatable {
  const NotificationCenterState({
    this.status = NotificationCenterStatus.init,
    this.options,
  });

  final NotificationCenterStatus status;
  final List<NotificationCenterOption>? options;

  @override
  List<Object?> get props => [status];

  NotificationCenterState copyWith({
    NotificationCenterStatus? status,
    List<NotificationCenterOption>? options,
  }) {
    return NotificationCenterState(
      status: status ?? this.status,
      options: options ?? this.options,
    );
  }
}
