part of 'sign_bloc.dart';

abstract class SignEvent extends Equatable {
  const SignEvent();
}

class SignUpInfoRequest extends SignEvent {
  const SignUpInfoRequest({
    this.name,
    this.lastName,
    this.email,
    this.password,
  });

  final NameValidatorModel? name;
  final LastNameValidatorModel? lastName;
  final EmailValidatorModel? email;
  final PasswordValidatorModel? password;

  @override
  List<Object?> get props => [name, lastName, email, password];
}

class SignUpPasswordIsShowRequest extends SignEvent {
  const SignUpPasswordIsShowRequest(this.isShowPassword);

  final bool isShowPassword;

  @override
  List<Object> get props => [isShowPassword];
}

class SignUpIntentRequest extends SignEvent {
  const SignUpIntentRequest();

  @override
  List<Object> get props => [];
}
