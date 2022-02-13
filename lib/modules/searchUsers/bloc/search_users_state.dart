// ignore_for_file: must_be_immutable

part of 'search_users_bloc.dart';

enum SearchUsersStatus { success, searching, waiting }

class SearchUsersState extends Equatable {
  const SearchUsersState({
    this.status = SearchUsersStatus.success,
    this.users,
    this.query,
  });

  final SearchUsersStatus status;
  final Stream<List<User>>? users;
  final String? query;

  @override
  List<Object> get props => [status];

  SearchUsersState copyWith({
    SearchUsersStatus? status,
    Stream<List<User>>? users,
    String? query,
  }) {
    return SearchUsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      query: query ?? this.query,
    );
  }
}
