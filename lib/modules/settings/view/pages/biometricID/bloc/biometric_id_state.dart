part of 'biometric_id_bloc.dart';

enum BiometricIDStatus { init, loading }

class BiometricIDState extends Equatable {
  const BiometricIDState({
    this.status = BiometricIDStatus.init,
    this.isEnable,
    this.isInitEnable,
  });

  final BiometricIDStatus status;
  final bool? isEnable;
  final bool? isInitEnable;

  bool get isCorrectLoged => isEnable ?? false;

  @override
  List<Object?> get props => [status, isEnable, isInitEnable];

  BiometricIDState copyWith({
    BiometricIDStatus? status,
    String? pinCode,
    bool? isEnable,
    bool? isInitEnable,
  }) {
    return BiometricIDState(
      status: status ?? this.status,
      isInitEnable: isInitEnable,
      isEnable: isEnable,
    );
  }
}
