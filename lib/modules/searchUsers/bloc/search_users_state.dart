// ignore_for_file: must_be_immutable

part of 'search_users_bloc.dart';

enum SearchUsersStatus { success, searching, failure, loading }

class SearchUsersState extends Equatable {
  const SearchUsersState({
    this.status = SearchUsersStatus.success,
    this.selectedUsers = const [],
    this.users,
    this.query,
  });

  final SearchUsersStatus status;
  final Stream<List<User>>? users;
  final List<User>? selectedUsers;
  final String? query;

  List<User> getFilteredUsers(List<User>? users, String query) {
    final _users = users ?? [];
    return _users
        .where(
          (e) =>
              e.firstName!.contains(query) ||
              e.lastName!.contains(query) ||
              e.userName!.contains(query) ||
              e.email!.contains(query),
        )
        .toList();
  }

  @override
  List<Object?> get props => [status, query, selectedUsers, users];

  SearchUsersState copyWith({
    SearchUsersStatus? status,
    Stream<List<User>>? users,
    List<User>? selectedUsers,
    String? query,
  }) {
    return SearchUsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      query: query ?? this.query,
    );
  }
}
