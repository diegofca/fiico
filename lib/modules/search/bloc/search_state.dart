// ignore_for_file: must_be_immutable

part of 'search_bloc.dart';

enum SearchStatus { success, searching, waiting }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.success,
    this.budgets,
    this.users,
    this.movements,
    this.query,
    this.index,
  });

  final SearchStatus status;
  final Stream<List<User>>? users;
  final Stream<List<Budget>>? budgets;
  final Stream<List<Movement>>? movements;

  final String? query;
  final int? index;

  bool get showUsers => index == 0 || index == 1;
  bool get showBudgets => index == 0 || index == 2;

  @override
  List<Object> get props => [status];

  SearchState copyWith({
    SearchStatus? status,
    Stream<List<User>>? users,
    Stream<List<Budget>>? budgets,
    Stream<List<Movement>>? movements,
    String? query,
    int? index = 0,
  }) {
    return SearchState(
      status: status ?? this.status,
      users: users ?? this.users,
      budgets: budgets ?? this.budgets,
      movements: movements ?? this.movements,
      query: query ?? this.query,
      index: index ?? this.index,
    );
  }
}
