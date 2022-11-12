import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pincode_unlock_event.dart';
part 'pincode_unlock_state.dart';

class PinCodeUnlockBloc extends Bloc<PinCodeUnlockEvent, PinCodeUnlockState> {
  PinCodeUnlockBloc() : super(const PinCodeUnlockState()) {
    on<PinCodeUnlockPinTextRequest>(_mapNewPinTextToState);
    on<PinCodeUnlockCorrectPinRequest>(_mapCorrectPinToState);
  }

  void _mapNewPinTextToState(
    PinCodeUnlockPinTextRequest event,
    Emitter<PinCodeUnlockState> emit,
  ) async {
    emit(state.copyWith(
      status: PinCodeUnlockStatus.loading,
      pinCode: event.pinCode,
    ));
  }

  void _mapCorrectPinToState(
    PinCodeUnlockCorrectPinRequest event,
    Emitter<PinCodeUnlockState> emit,
  ) async {
    emit(state.copyWith(status: PinCodeUnlockStatus.loading));
    emit(state.copyWith(
      status: PinCodeUnlockStatus.init,
      isCorrect: event.isCorrect,
    ));
  }
}
