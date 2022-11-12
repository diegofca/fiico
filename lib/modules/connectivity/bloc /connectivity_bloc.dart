import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:control/modules/connectivity/repository/connectivity_repository.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc({required this.connectivityRepository})
      : super(const ConnectivityState(connected: true, isResumed: true)) {
    // Stream callbacks
    on<ConnectivityStartListening>(_mapConnectivityStartListening,
        transformer: sequential());
    on<ConnectivityStopListening>(_mapConnectivityStopListening,
        transformer: sequential());
    on<ConnectivityUpdated>(_mapConnectivityUpdated, transformer: sequential());
    on<ConnectivityCheckRequested>(_mapConnectivityCheckRequested,
        transformer: sequential());
    on<ConnectivityUpdateIsResumed>(_mapConnectivityUpdateIsCurrent,
        transformer: sequential());

    _streamSubscription = connectivityRepository.connected.listen(
      (connected) => add(ConnectivityUpdated(connected)),
    );
  }

  final ConnectivityRepository connectivityRepository;
  late StreamSubscription<bool> _streamSubscription;

  void _mapConnectivityUpdated(
    ConnectivityUpdated event,
    Emitter<ConnectivityState> emit,
  ) async {
    final newState = state.copyWith(connected: event.connected);
    emit(newState);
  }

  void _mapConnectivityStopListening(
    ConnectivityStopListening event,
    Emitter<ConnectivityState> emit,
  ) async {
    await connectivityRepository.stop();
  }

  void _mapConnectivityStartListening(
    ConnectivityStartListening event,
    Emitter<ConnectivityState> emit,
  ) async {
    await connectivityRepository.start();
  }

  void _mapConnectivityCheckRequested(
    ConnectivityCheckRequested event,
    Emitter<ConnectivityState> emit,
  ) async {
    final connected = await connectivityRepository.hasConnectivity();
    emit(state.copyWith(connected: connected));
  }

  void _mapConnectivityUpdateIsCurrent(
    ConnectivityUpdateIsResumed event,
    Emitter<ConnectivityState> emit,
  ) async {
    final newState = state.copyWith(isResumed: event.isResumed);
    emit(newState);
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
