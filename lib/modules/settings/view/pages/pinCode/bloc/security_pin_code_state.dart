part of 'security_pin_code_bloc.dart';

enum SecurityPinCodeStatus { init, loading }

class SecurityPinCodeState extends Equatable {
  const SecurityPinCodeState({
    this.status = SecurityPinCodeStatus.init,
    this.isChangePinCode,
    this.isUpdatePinCode,
    this.isUnlockChange,
    this.newPin,
    this.oldPin,
  });

  final SecurityPinCodeStatus status;
  final String? newPin;
  final String? oldPin;

  final bool? isChangePinCode;
  final bool? isUpdatePinCode;
  final bool? isUnlockChange;

  bool get isPinUpdated => isUpdatePinCode ?? false;
  bool get isValidPin => (newPin?.length ?? 0) > 3;

  @override
  List<Object?> get props => [
        status,
        newPin,
        isChangePinCode,
        isUpdatePinCode,
        isUnlockChange,
        oldPin
      ];

  SecurityPinCodeState copyWith({
    SecurityPinCodeStatus? status,
    int? budgetSelected,
    bool? isChangePinCode,
    bool? isUpdatePinCode,
    bool? isUnlockChange,
    String? newPin,
    String? oldPin,
  }) {
    return SecurityPinCodeState(
      status: status ?? this.status,
      isChangePinCode: isChangePinCode ?? this.isChangePinCode,
      isUpdatePinCode: isUpdatePinCode ?? this.isUpdatePinCode,
      isUnlockChange: isUnlockChange ?? this.isUnlockChange,
      newPin: newPin ?? this.newPin,
      oldPin: oldPin ?? this.oldPin,
    );
  }
}
