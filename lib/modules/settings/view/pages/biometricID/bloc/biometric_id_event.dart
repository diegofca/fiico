part of 'biometric_id_bloc.dart';

abstract class BiometricIDEvent extends Equatable {
  const BiometricIDEvent();
}

class BiometricIDInitEnable extends BiometricIDEvent {
  const BiometricIDInitEnable({required this.isEnable});

  final bool? isEnable;

  @override
  List<Object?> get props => [isEnable];
}

class BiometricIDEnableRequest extends BiometricIDEvent {
  const BiometricIDEnableRequest({required this.isEnable});

  final bool? isEnable;

  @override
  List<Object?> get props => [isEnable];
}
