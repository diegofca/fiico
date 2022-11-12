import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/editProfile/repository/edit_profile_repository.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this.repository) : super(const EditProfileState()) {
    on<EditProfileRequest>(_mapUpdateInfoToState);
    on<EditProfileInfoRequest>(_mapChangeInfoToState);
    on<EditProfileInitDataRequest>(_mapInitInfoToState);
  }

  final EditProfileRepository repository;

  void _mapInitInfoToState(
    EditProfileInitDataRequest event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    emit(state.copyWith(
      status: EditProfileStatus.success,
      name: event.user?.firstName,
      lastName: event.user?.lastName,
      userName: event.user?.userName,
    ));
  }

  void _mapUpdateInfoToState(
    EditProfileRequest event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    try {
      final user = await Preferences.get.getUser();
      final newUser = user?.copyWith(
        firstName: state.name,
        lastName: state.lastName,
        userName: state.userName,
        defaultCurrency: state.currency,
      );
      await repository.updateProfile(newUser);
      emit(state.copyWith(
        status: EditProfileStatus.success,
        user: newUser,
        updatedUser: true,
      ));
    } catch (_) {
      emit(state.copyWith(status: EditProfileStatus.failure));
    }
  }

  void _mapChangeInfoToState(
    EditProfileInfoRequest event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    emit(state.copyWith(
      status: EditProfileStatus.success,
      name: event.name,
      lastName: event.lastName,
      userName: event.userName,
      currency: event.currency,
    ));
  }
}
