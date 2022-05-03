import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/modules/settings/view/pages/biometricID/repository/biometric_id_repository.dart';
import 'package:equatable/equatable.dart';

part 'biometric_id_event.dart';
part 'biometric_id_state.dart';

class BiometricIDBloc extends Bloc<BiometricIDEvent, BiometricIDState> {
  BiometricIDBloc(this.repository) : super(const BiometricIDState()) {
    on<BiometricIDEnableRequest>(_mapIsEnableBiometricToState);
    on<BiometricIDInitEnable>(_mapIsEnableInitBiometricToState);
  }

  final BiometricIDRepository repository;

  void _mapIsEnableBiometricToState(
    BiometricIDEnableRequest event,
    Emitter<BiometricIDState> emit,
  ) async {
    emit(state.copyWith(status: BiometricIDStatus.loading));
    final user = await Preferences.get.getUser();
    await repository.updateBiometricUser(user, event.isEnable);
    emit(state.copyWith(
      status: BiometricIDStatus.init,
      isEnable: event.isEnable,
    ));
  }

  void _mapIsEnableInitBiometricToState(
    BiometricIDInitEnable event,
    Emitter<BiometricIDState> emit,
  ) async {
    emit(state.copyWith(status: BiometricIDStatus.loading));
    final user = await Preferences.get.getUser();
    await repository.updateBiometricUser(user, event.isEnable);
    emit(state.copyWith(
      status: BiometricIDStatus.init,
      isInitEnable: event.isEnable,
    ));
  }
}
