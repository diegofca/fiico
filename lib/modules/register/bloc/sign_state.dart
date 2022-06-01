// ignore_for_file: must_be_immutable

part of 'sign_bloc.dart';

enum SignStatus { success, loading, failure }
enum SignUpError { userNotFound, wrongPassword, toManyRequest, unknow }

class SignState extends Equatable {
  const SignState({
    this.status = SignStatus.success,
    this.email = const EmailValidatorModel(''),
    this.password = const PasswordValidatorModel(''),
    this.lastName = const LastNameValidatorModel(''),
    this.name = const NameValidatorModel(''),
    this.isShowPassword,
    this.userLogged,
    this.errorType,
    this.errorMgs,
    this.currency,
  });

  final SignStatus status;
  final EmailValidatorModel? email;
  final PasswordValidatorModel? password;
  final NameValidatorModel? name;
  final LastNameValidatorModel? lastName;
  final Currency? currency;

  final bool? isShowPassword;
  final FiicoUser? userLogged;
  final SignUpError? errorType;
  final String? errorMgs;

  bool get signUpError => errorType != null;
  bool get signUpComplete => status == SignStatus.success && userLogged != null;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        name,
        lastName,
        currency,
        isShowPassword,
        userLogged,
        errorType,
        errorMgs
      ];

  SignState copyWith({
    SignStatus? status,
    EmailValidatorModel? email,
    PasswordValidatorModel? password,
    NameValidatorModel? name,
    LastNameValidatorModel? lastName,
    Currency? currency,
    bool? isShowPassword,
    FiicoUser? userLogged,
    SignUpError? errorType,
    String? errorMgs,
  }) {
    return SignState(
      status: status ?? this.status,
      password: password ?? this.password,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      currency: currency ?? this.currency,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      name: name ?? this.name,
      userLogged: userLogged,
      errorType: errorType,
      errorMgs: errorMgs,
    );
  }
}
