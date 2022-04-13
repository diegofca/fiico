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
    emit(state.copyWith(status: LoginStatus.loading));
    final sendEvent =
        await repository.forgotPasswordWithEmail(event.email, (eType, eMssg) {
      _mapErrorToIntentLogin(emit, eType, eMssg);
    });

    emit(state.copyWith(
      status: LoginStatus.success,
      isSendForgotEmail: sendEvent,
    ));
  }

  void _mapIntentLoginToState(
    LoginIntentRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final userLogged =
        await repository.loginUserWithEmail(state, (eType, eMssg) {
      _mapErrorToIntentLogin(emit, eType, eMssg);
    });

    if (userLogged != null) {
      emit(state.copyWith(
        status: LoginStatus.success,
        userLogged: userLogged,
      ));
    }
  }

  void _mapErrorToIntentLogin(
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
      case "ERROR_INVALID_EMAIL":
      //   errorMessage = "Your email address appears to be malformed.";
      //   break;
      // case "ERROR_WRONG_PASSWORD":
      //   errorMessage = "Your password is wrong.";
      //   break;
      // case "ERROR_USER_NOT_FOUND":
      //   errorMessage = "User with this email doesn't exist.";
      //   break;
      // case "ERROR_USER_DISABLED":
      //   errorMessage = "User with this email has been disabled.";
      //   break;
      // case "ERROR_TOO_MANY_REQUESTS":
      //   errorMessage = "Too many requests. Try again later.";
      //   break;
      // case "ERROR_OPERATION_NOT_ALLOWED":
      //   errorMessage = "Signing in with Email and Password is not enabled.";
      //   break;
      default:
        return LoginError.unknow;
    }
  }
}
