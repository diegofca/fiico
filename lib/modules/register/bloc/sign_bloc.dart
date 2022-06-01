import 'package:bloc/bloc.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/login/model/login_validator_email_model.dart';
import 'package:control/modules/login/model/login_validator_password_model.dart';
import 'package:control/modules/register/model/last_name_validator_model.dart';
import 'package:control/modules/register/model/name_validator_model.dart';
import 'package:control/modules/register/repository/sign_up_repository.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';

part 'sign_state.dart';
part 'sign_event.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  SignBloc(this.repository) : super(const SignState()) {
    on<SignUpInfoRequest>(_mapUserInfoToState);
    on<SignUpPasswordIsShowRequest>(_mapPassIsShowToState);
    on<SignUpIntentRequest>(_mapIntentSignUpToState);
  }

  final SignUpRepository repository;

  void _mapUserInfoToState(
    SignUpInfoRequest event,
    Emitter<SignState> emit,
  ) async {
    emit(state.copyWith(
      status: SignStatus.success,
      password: event.password,
      email: event.email,
      lastName: event.lastName,
      name: event.name,
      currency: event.currency,
    ));
  }

  void _mapPassIsShowToState(
    SignUpPasswordIsShowRequest event,
    Emitter<SignState> emit,
  ) async {
    emit(state.copyWith(
      status: SignStatus.success,
      isShowPassword: event.isShowPassword,
    ));
  }

  void _mapIntentSignUpToState(
    SignUpIntentRequest event,
    Emitter<SignState> emit,
  ) async {
    emit(state.copyWith(status: SignStatus.loading));
    final userLogged =
        await repository.createUserWithEmail(state, (eType, eMssg) {
      _mapErrorToIntentSignUp(event, emit, eType, eMssg);
    });

    if (userLogged != null) {
      emit(state.copyWith(
        status: SignStatus.success,
        userLogged: userLogged,
      ));
    }
  }

  void _mapErrorToIntentSignUp(
    SignUpIntentRequest event,
    Emitter<SignState> emit,
    String eType,
    String? eMessage,
  ) {
    emit(state.copyWith(
      status: SignStatus.failure,
      errorType: _getLoginErrorType(eType),
      errorMgs: eMessage,
    ));
  }

  SignUpError? _getLoginErrorType(String error) {
    switch (error) {
      case 'user-not-found':
        return SignUpError.userNotFound;
      case 'wrong-password':
        return SignUpError.wrongPassword;
      case 'too-many-requests':
        return SignUpError.toManyRequest;
      default:
        return SignUpError.unknow;
    }
  }
}
