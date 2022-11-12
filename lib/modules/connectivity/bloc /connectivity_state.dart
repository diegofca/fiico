part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  const ConnectivityState({
    required this.connected,
    required this.isResumed,
  });

  final bool connected;
  final bool isResumed;

  ConnectivityState copyWith({
    bool? connected,
    bool? isResumed,
  }) {
    return ConnectivityState(
      connected: connected ?? this.connected,
      isResumed: isResumed ?? this.isResumed,
    );
  }

  @override
  List<Object?> get props => [connected, isResumed];
}
