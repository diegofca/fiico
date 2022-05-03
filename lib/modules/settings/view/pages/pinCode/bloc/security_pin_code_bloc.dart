import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/modules/settings/view/pages/pinCode/repository/security_pin_code_repository.dart';
import 'package:equatable/equatable.dart';

part 'security_pin_code_event.dart';
part 'security_pin_code_state.dart';

class SecurityPinCodeBloc
    extends Bloc<SecurityPinCodeEvent, SecurityPinCodeState> {
  SecurityPinCodeBloc(this.repository) : super(const SecurityPinCodeState()) {
    on<SecurityPinCodeChangePINRequest>(_mapChangePinRequestToState);
    on<SecurityNewPinTextRequest>(_mapNewPinTextToState);
    on<SecurityPinUpdateIntentRequest>(_maPinUpdateIntentToState);
    on<SecurityOldPinTextRequest>(_mapOldPinTextToState);
    on<SecurityPinCodeChangeUnLockRequest>(_mapChangeUnlockRequestToState);
  }

  final SecurityPinCodeRepository repository;

  void _mapChangePinRequestToState(
    SecurityPinCodeChangePINRequest event,
    Emitter<SecurityPinCodeState> emit,
  ) async {
    emit(state.copyWith(
      status: SecurityPinCodeStatus.init,
      isChangePinCode: event.isChange,
    ));
  }

  void _mapChangeUnlockRequestToState(
    SecurityPinCodeChangeUnLockRequest event,
    Emitter<SecurityPinCodeState> emit,
  ) async {
    emit(state.copyWith(
      status: SecurityPinCodeStatus.init,
      isUnlockChange: event.isUnLock,
    ));
  }

  void _mapNewPinTextToState(
    SecurityNewPinTextRequest event,
    Emitter<SecurityPinCodeState> emit,
  ) async {
    emit(state.copyWith(
      status: SecurityPinCodeStatus.init,
      newPin: event.pinCode,
    ));
  }

  void _mapOldPinTextToState(
    SecurityOldPinTextRequest event,
    Emitter<SecurityPinCodeState> emit,
  ) async {
    emit(state.copyWith(
      status: SecurityPinCodeStatus.init,
      oldPin: event.oldPinCode,
    ));
  }

  void _maPinUpdateIntentToState(
    SecurityPinUpdateIntentRequest event,
    Emitter<SecurityPinCodeState> emit,
  ) async {
    emit(state.copyWith(status: SecurityPinCodeStatus.loading));
    final user = await Preferences.get.getUser();
    if (state.isValidPin) {
      await repository.updateUser(user, state.newPin);
      emit(state.copyWith(
        status: SecurityPinCodeStatus.init,
        isUpdatePinCode: true,
      ));
    }
  }
}
