import 'package:bloc/bloc.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/login/model/login_validator_email_model.dart';
import 'package:control/modules/login/model/login_validator_password_model.dart';
import 'package:control/modules/login/repository/login_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.repository) : super(const LoginState()) {
    on<LoginValidateEmailRequest>(_mapEmailValidatorToState);
    on<LoginValidatePasswordRequest>(_mapPassValidatorToState);
    on<LoginPasswordIsShowRequest>(_mapPassIsShowToState);
    on<LoginIntentRequest>(_mapIntentLoginToState);
    on<LoginForgotPasswordRequest>(_mapRecoverPasswordToState);
  }

  final LoginRepository repository;

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

  void _mapRecoverPasswordToState(
    LoginForgotPasswordRequest event,
    Emitter<LoginState> emit,
  ) async {
    await repository.forgotPasswordWithEmail(event.email);

    emit(state.copyWith(
      status: LoginStatus.success,
      // email: event.email,
    ));
  }

  void _mapIntentLoginToState(
    LoginIntentRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final userLogged =
        await repository.loginUserWithEmail(state, (eType, eMssg) {
      _mapErrorToIntentLogin(event, emit, eType, eMssg);
    });

    if (userLogged != null) {
      emit(state.copyWith(
        status: LoginStatus.success,
        userLogged: userLogged,
      ));
    }
  }

  void _mapErrorToIntentLogin(
    LoginIntentRequest event,
    Emitter<LoginState> emit,
    String eType,
    String? eMessage,
  ) {
    emit(state.copyWith(
      status: LoginStatus.failure,
      errorType: _getLoginErrorType(eType),
      errorMgs: eMessage,
    ));
  }

  LoginError? _getLoginErrorType(String error) {
    switch (error) {
      case 'user-not-found':
        return LoginError.userNotFound;
      case 'wrong-password':
        return LoginError.wrongPassword;
      case 'too-many-requests':
        return LoginError.toManyRequest;
      default:
        return LoginError.unknow;
    }
  }
}
