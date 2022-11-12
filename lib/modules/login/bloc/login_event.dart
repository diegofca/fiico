part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginInitEvent extends LoginEvent {
  const LoginInitEvent();

  @override
  List<Object> get props => [];
}

class LoginValidateEmailRequest extends LoginEvent {
  const LoginValidateEmailRequest(this.email);

  final EmailValidatorModel email;

  @override
  List<Object> get props => [email];
}

class LoginValidatePasswordRequest extends LoginEvent {
  const LoginValidatePasswordRequest(this.password);

  final PasswordValidatorModel password;

  @override
  List<Object> get props => [password];
}

class LoginPasswordIsShowRequest extends LoginEvent {
  const LoginPasswordIsShowRequest(this.isShowPassword);

  final bool isShowPassword;

  @override
  List<Object> get props => [isShowPassword];
}

enum LoginIntentProvider { email, fb, apple, google }

class LoginIntentRequest extends LoginEvent {
  const LoginIntentRequest(this.provider);

  final LoginIntentProvider provider;

  @override
  List<Object> get props => [provider];
}

class LoginForgotPasswordRequest extends LoginEvent {
  const LoginForgotPasswordRequest(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
