part of 'security_pin_code_bloc.dart';

abstract class SecurityPinCodeEvent extends Equatable {
  const SecurityPinCodeEvent();
}

class SecurityPinCodeChangePINRequest extends SecurityPinCodeEvent {
  const SecurityPinCodeChangePINRequest({this.isChange});

  final bool? isChange;

  @override
  List<Object?> get props => [isChange];
}

class SecurityNewPinTextRequest extends SecurityPinCodeEvent {
  const SecurityNewPinTextRequest({required this.pinCode});

  final String? pinCode;

  @override
  List<Object?> get props => [pinCode];
}

class SecurityOldPinTextRequest extends SecurityPinCodeEvent {
  const SecurityOldPinTextRequest({required this.oldPinCode});

  final String? oldPinCode;

  @override
  List<Object?> get props => [oldPinCode];
}

class SecurityPinUpdateIntentRequest extends SecurityPinCodeEvent {
  const SecurityPinUpdateIntentRequest();

  @override
  List<Object?> get props => [];
}

class SecurityPinCodeChangeUnLockRequest extends SecurityPinCodeEvent {
  const SecurityPinCodeChangeUnLockRequest({this.isUnLock});

  final bool? isUnLock;

  @override
  List<Object?> get props => [isUnLock];
}
