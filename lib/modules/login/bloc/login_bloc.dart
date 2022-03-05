import 'package:bloc/bloc.dart';
import 'package:control/modules/login/model/login_validator_email_model.dart';
import 'package:control/modules/login/model/login_validator_password_model.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginValidateEmailRequest>(_mapEmailValidatorToState);
    on<LoginValidatePasswordRequest>(_mapPassValidatorToState);
    on<LoginPasswordIsShowRequest>(_mapPassIsShowToState);
  }

  void _mapEmailValidatorToState(
    LoginValidateEmailRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      status: LoginStatus.success,
      email: event.email,
    ));
  }

  void _mapPassValidatorToState(
    LoginValidatePasswordRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      status: LoginStatus.success,
      password: event.password,
    ));
  }

  void _mapPassIsShowToState(
    LoginPasswordIsShowRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      status: LoginStatus.success,
      isShowPassword: event.isShowPassword,
    ));
  }
}
