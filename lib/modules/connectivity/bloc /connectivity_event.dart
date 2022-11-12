part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
}

class ConnectivityUpdated extends ConnectivityEvent {
  const ConnectivityUpdated(this.connected);

  final bool connected;

  @override
  List<Object> get props => [connected];
}

class ConnectivityStopListening extends ConnectivityEvent {
  const ConnectivityStopListening();

  @override
  List<Object> get props => [];
}

class ConnectivityStartListening extends ConnectivityEvent {
  const ConnectivityStartListening();

  @override
  List<Object> get props => [];
}

class ConnectivityCheckRequested extends ConnectivityEvent {
  const ConnectivityCheckRequested();

  @override
  List<Object> get props => [];
}

class ConnectivityUpdateIsResumed extends ConnectivityEvent {
  const ConnectivityUpdateIsResumed({required this.isResumed});

  final bool isResumed;

  @override
  List<Object> get props => [isResumed];
}
