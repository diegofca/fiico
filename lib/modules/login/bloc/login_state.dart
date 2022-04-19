// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

enum LoginStatus { success, loading, failure }
enum LoginError { userNotFound, wrongPassword, toManyRequest, unknow }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.loading,
    this.email = const EmailValidatorModel(''),
    this.password = const PasswordValidatorModel(''),
    this.isSendForgotEmail,
    this.isShowPassword,
    this.userLogged,
    this.errorType,
    this.errorMgs,
  });

  final LoginStatus status;
  final EmailValidatorModel? email;
  final PasswordValidatorModel? password;
  final bool? isShowPassword;
  final bool? isSendForgotEmail;
  final FiicoUser? userLogged;
  final LoginError? errorType;
  final String? errorMgs;

  bool get loginError => errorType != null;
  bool get loginComplete => status == LoginStatus.success && userLogged != null;
  bool get isRecoverPass =>
      status == LoginStatus.success && (isSendForgotEmail ?? false);

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        isShowPassword,
        userLogged,
        errorType,
        errorMgs,
        isSendForgotEmail,
      ];

  LoginState copyWith({
    LoginStatus? status,
    EmailValidatorModel? email,
    PasswordValidatorModel? password,
    bool? isSendForgotEmail,
    bool? isShowPassword,
    FiicoUser? userLogged,
    LoginError? errorType,
    String? errorMgs,
  }) {
    return LoginState(
      status: status ?? this.status,
      password: password ?? this.password,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      email: email ?? this.email,
      isSendForgotEmail: isSendForgotEmail,
      userLogged: userLogged,
      errorType: errorType,
      errorMgs: errorMgs,
    );
  }
}
