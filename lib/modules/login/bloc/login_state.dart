// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

enum LoginStatus { success, loading, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.success,
    this.email = const EmailValidatorModel(''),
    this.password = const PasswordValidatorModel(''),
    this.isShowPassword,
  });

  final LoginStatus status;
  final EmailValidatorModel? email;
  final PasswordValidatorModel? password;
  final bool? isShowPassword;

  @override
  List<Object?> get props => [status, email, password, isShowPassword];

  LoginState copyWith({
    LoginStatus? status,
    EmailValidatorModel? email,
    PasswordValidatorModel? password,
    bool? isShowPassword,
  }) {
    return LoginState(
      status: status ?? this.status,
      password: password ?? this.password,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      email: email ?? this.email,
    );
  }
}
