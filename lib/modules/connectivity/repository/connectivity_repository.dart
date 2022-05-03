import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

/// {@template connectivity_repository}
/// Repository to get information about the device connectivity.
/// {@endtemplate}
class ConnectivityRepository {
  /// {@macro connectivity_repository}
  ConnectivityRepository({
    Connectivity? connectivity,
    InternetConnectionChecker? connectionChecker,
  })  : _connectivity = connectivity ?? Connectivity(),
        _connectionChecker = connectionChecker ??
            (InternetConnectionChecker()
              ..checkInterval = const Duration(seconds: 5)),
        _connectedStream = BehaviorSubject<bool>();

  final Connectivity _connectivity;
  final InternetConnectionChecker _connectionChecker;
  final BehaviorSubject<bool> _connectedStream;

  StreamSubscription<InternetConnectionStatus>? _connectionCheckerSubscription;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  /// A stream indicating whether the device has a internet connection.
  Stream<bool> get connected => _connectedStream.stream.distinct();

  /// Starts listening to the connectivity changes.
  Future<void> start() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChange,
    );

    _connectionCheckerSubscription = _connectionChecker.onStatusChange.listen(
      _onConnectionStatusChange,
    );
  }

  /// Stops listening to the connectivity changes.
  Future<void> stop() async {
    await _connectivitySubscription?.cancel();
    await _connectionCheckerSubscription?.cancel();
  }

  Future<void> _onConnectivityChange(ConnectivityResult result) async {
    _connectedStream.add(await _onConnectionStatusToInternet(result));
  }

  Future<bool> _onConnectionStatusToInternet(ConnectivityResult result) async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return _connectionChecker.hasConnection;
  }

  void _onConnectionStatusChange(InternetConnectionStatus status) {
    _connectedStream.add(status == InternetConnectionStatus.connected);
  }

  /// Returns whether the device has an internet connection.
  Future<bool> hasConnectivity() async => _connectionChecker.hasConnection;
}
