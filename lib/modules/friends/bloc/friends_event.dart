part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();
}

class InvitationsListFetchRequest extends FriendsEvent {
  const InvitationsListFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}

class FriendsListFetchRequest extends FriendsEvent {
  const FriendsListFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}

class SendRequestFriendRequest extends FriendsEvent {
  const SendRequestFriendRequest({
    this.user,
  });

  final FiicoUser? user;

  @override
  List<Object?> get props => [user];
}

class AcceptedInvitationRequest extends FriendsEvent {
  const AcceptedInvitationRequest({
    this.invite,
  });

  final InviteFriend? invite;

  @override
  List<Object?> get props => [invite];
}

class RejectedInvitationRequest extends FriendsEvent {
  const RejectedInvitationRequest({
    this.invite,
  });

  final InviteFriend? invite;

  @override
  List<Object?> get props => [invite];
}
