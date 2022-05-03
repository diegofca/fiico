part of 'pincode_unlock_bloc.dart';

enum PinCodeUnlockStatus { init, loading }

class PinCodeUnlockState extends Equatable {
  const PinCodeUnlockState({
    this.status = PinCodeUnlockStatus.init,
    this.pinCode,
    this.isCorrect,
  });

  final PinCodeUnlockStatus status;
  final String? pinCode;
  final bool? isCorrect;

  bool get isCorrectPin => isCorrect ?? false;

  @override
  List<Object?> get props => [status, pinCode];

  PinCodeUnlockState copyWith({
    PinCodeUnlockStatus? status,
    String? pinCode,
    bool? isCorrect,
  }) {
    return PinCodeUnlockState(
      status: status ?? this.status,
      pinCode: pinCode ?? this.pinCode,
      isCorrect: isCorrect,
    );
  }
}
