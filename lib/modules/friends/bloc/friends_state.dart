part of 'friends_bloc.dart';

enum FriendStatus { init, loading, success }

enum InvitationState { sendRequest, accepted, rejected }

class FriendState extends Equatable {
  const FriendState({
    this.status = FriendStatus.init,
    this.invitations,
    this.friends,
    this.state,
  });

  final FriendStatus status;
  final Stream<List<InviteFriend>>? invitations;
  final Stream<List<FiicoUser>>? friends;

  final InvitationState? state;

  @override
  List<Object?> get props => [status, friends, invitations, state];

  FriendState copyWith({
    FriendStatus? status,
    Stream<List<InviteFriend>>? invitations,
    Stream<List<FiicoUser>>? friends,
    InvitationState? state,
  }) {
    return FriendState(
      status: status ?? this.status,
      invitations: invitations ?? this.invitations,
      friends: friends ?? this.friends,
      state: state,
    );
  }
}
