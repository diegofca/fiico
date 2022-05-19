part of 'edit_profile_bloc.dart';

enum EditProfileStatus { success, loading, failure }

class EditProfileState extends Equatable {
  const EditProfileState({
    this.status = EditProfileStatus.loading,
    this.name,
    this.lastName,
    this.userName,
    this.updatedUser,
    this.user,
  });

  final EditProfileStatus status;
  final String? name;
  final String? lastName;
  final String? userName;
  final bool? updatedUser;
  final FiicoUser? user;

  bool get onUpdateComplete => updatedUser ?? false;

  @override
  List<Object> get props => [status];

  EditProfileState copyWith({
    EditProfileStatus? status,
    String? name,
    String? lastName,
    String? userName,
    bool? updatedUser,
    FiicoUser? user,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      updatedUser: updatedUser,
      user: user,
    );
  }
}
