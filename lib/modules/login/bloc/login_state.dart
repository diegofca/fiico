// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

enum LoginStatus { success, loading, failure }
enum LoginError { userNotFound, wrongPassword, toManyRequest, unknow }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.success,
    this.email = const EmailValidatorModel(''),
    this.password = const PasswordValidatorModel(''),
    this.isShowPassword,
    this.userLogged,
    this.errorType,
    this.errorMgs,
  });

  final LoginStatus status;
  final EmailValidatorModel? email;
  final PasswordValidatorModel? password;
  final bool? isShowPassword;
  final FiicoUser? userLogged;
  final LoginError? errorType;
  final String? errorMgs;

  bool get loginError => errorType != null;
  bool get loginComplete => status == LoginStatus.success && userLogged != null;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        isShowPassword,
        userLogged,
        errorType,
        errorMgs
      ];

  LoginState copyWith({
    LoginStatus? status,
    EmailValidatorModel? email,
    PasswordValidatorModel? password,
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
      userLogged: userLogged,
      errorType: errorType,
      errorMgs: errorMgs,
    );
  }
}
