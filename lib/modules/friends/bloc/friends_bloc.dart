import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/modules/friends/repository/friends_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:control/models/user.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendState> {
  FriendsBloc(this.repository) : super(const FriendState()) {
    on<InvitationsListFetchRequest>(_mapInvitationsFetchToState);
    on<SendRequestFriendRequest>(_mapSendRequestFriendToState);
    on<AcceptedInvitationRequest>(_mapAcceptedInvitationRequestToState);
    on<RejectedInvitationRequest>(_mapRejectedInvitationRequestToState);
    on<FriendsListFetchRequest>(_mapFriendsFetchToState);
  }

  final FriendsRepository repository;

  void _mapInvitationsFetchToState(
    InvitationsListFetchRequest event,
    Emitter<FriendState> emit,
  ) async {
    emit(state.copyWith(status: FriendStatus.loading));
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: FriendStatus.success,
      invitations: repository.getInvitations(user?.id),
    ));
  }

  void _mapFriendsFetchToState(
    FriendsListFetchRequest event,
    Emitter<FriendState> emit,
  ) async {
    emit(state.copyWith(status: FriendStatus.loading));
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: FriendStatus.success,
      friends: repository.getFriends(user?.id),
    ));
  }

  void _mapSendRequestFriendToState(
    SendRequestFriendRequest event,
    Emitter<FriendState> emit,
  ) async {
    await repository.sendRequestFriend(event.user);
    emit(state.copyWith(
      status: FriendStatus.success,
      state: InvitationState.sendRequest,
    ));
  }

  void _mapAcceptedInvitationRequestToState(
    AcceptedInvitationRequest event,
    Emitter<FriendState> emit,
  ) async {
    await repository.acceptedFriend(event.invite);
    emit(state.copyWith(
      status: FriendStatus.success,
      state: InvitationState.accepted,
    ));
  }

  void _mapRejectedInvitationRequestToState(
    RejectedInvitationRequest event,
    Emitter<FriendState> emit,
  ) async {
    await repository.rejectFriend(event.invite);
    emit(state.copyWith(
      status: FriendStatus.success,
      state: InvitationState.rejected,
    ));
  }
}
