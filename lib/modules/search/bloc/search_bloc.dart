import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/friends/bloc/friends_bloc.dart';
import 'package:control/modules/search/repository/search_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(const SearchState()) {
    on<SearchUsersRequest>(_mapUsersSearchToState);
    on<SearchSelectSegment>(_mapSelectSegmentToState);
    on<SendRequestFriendRequest>(_mapSendRequestFriendToState);
  }

  final SearchRepository repository;

  void _mapUsersSearchToState(
    SearchUsersRequest event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.searching));

    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: SearchStatus.success,
      users: repository.searchUsers(user?.id, event.query),
      friends: repository.getFriends(user?.id),
      budgets: repository.searchBudgets(user?.id, event.query),
      movements: repository.searchMovements(user?.id, event.query),
      requestInvites: repository.getRequestedInvitations(user?.id),
      invites: repository.getInvitations(user?.id),
      query: event.query,
    ));
  }

  void _mapSelectSegmentToState(
    SearchSelectSegment event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.searching));
    emit(state.copyWith(
      status: SearchStatus.success,
      index: event.index,
    ));
  }

  void _mapSendRequestFriendToState(
    SendRequestFriendRequest event,
    Emitter<SearchState> emit,
  ) async {
    await repository.sendRequestFriend(event.user);
    emit(state.copyWith(
      status: SearchStatus.success,
      requestState: InvitationState.sendRequest,
    ));
  }
}
