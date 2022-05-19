part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class EditProfileInitDataRequest extends EditProfileEvent {
  const EditProfileInitDataRequest({
    required this.user,
  });

  final FiicoUser? user;

  @override
  List<Object?> get props => [user];
}

class EditProfileRequest extends EditProfileEvent {
  const EditProfileRequest();

  @override
  List<Object?> get props => [];
}

class EditProfileInfoRequest extends EditProfileEvent {
  const EditProfileInfoRequest({
    this.name,
    this.lastName,
    this.userName,
  });

  final String? name;
  final String? lastName;
  final String? userName;

  @override
  List<Object?> get props => [name, lastName, userName];
}
