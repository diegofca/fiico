part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class NotificationssFetchRequest extends NotificationsEvent {
  const NotificationssFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}
