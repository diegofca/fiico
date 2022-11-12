// ignore_for_file: must_be_immutable

part of 'search_bloc.dart';

enum SearchStatus { success, searching, waiting }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.success,
    this.budgets,
    this.users,
    this.friends,
    this.movements,
    this.query,
    this.index,
    this.requestState,
    this.requestInvites,
    this.invites,
  });

  final SearchStatus status;
  final Stream<List<FiicoUser>>? users;
  final Stream<List<FiicoUser>>? friends;
  final Stream<List<Budget>>? budgets;
  final Stream<List<Movement>>? movements;
  final Stream<List<InviteFriend>>? invites;
  final Stream<List<InviteFriend>>? requestInvites;

  final InvitationState? requestState;

  final String? query;
  final int? index;

  bool get showUsers => index == 0 || index == 1;
  bool get showBudgets => index == 0 || index == 2;

  @override
  List<Object?> get props => [
        query,
        status,
        users,
        friends,
        budgets,
        movements,
        invites,
        requestState
      ];

  SearchState copyWith({
    SearchStatus? status,
    Stream<List<FiicoUser>>? users,
    Stream<List<FiicoUser>>? friends,
    Stream<List<Budget>>? budgets,
    Stream<List<Movement>>? movements,
    Stream<List<InviteFriend>>? invites,
    Stream<List<InviteFriend>>? requestInvites,
    String? query,
    int? index = 0,
    InvitationState? requestState,
  }) {
    return SearchState(
      status: status ?? this.status,
      users: users ?? this.users,
      friends: friends ?? this.friends,
      budgets: budgets ?? this.budgets,
      movements: movements ?? this.movements,
      requestInvites: requestInvites ?? this.requestInvites,
      invites: invites ?? this.invites,
      query: query ?? this.query,
      index: index ?? this.index,
      requestState: requestState,
    );
  }
}
