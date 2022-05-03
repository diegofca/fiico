part of 'pincode_unlock_bloc.dart';

abstract class PinCodeUnlockEvent extends Equatable {
  const PinCodeUnlockEvent();
}

class PinCodeUnlockPinTextRequest extends PinCodeUnlockEvent {
  const PinCodeUnlockPinTextRequest({required this.pinCode});

  final String? pinCode;

  @override
  List<Object?> get props => [pinCode];
}

class PinCodeUnlockCorrectPinRequest extends PinCodeUnlockEvent {
  const PinCodeUnlockCorrectPinRequest({required this.isCorrect});

  final bool? isCorrect;

  @override
  List<Object?> get props => [isCorrect];
}
