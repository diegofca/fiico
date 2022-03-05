part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class SearchUsersFetchRequest extends SearchUsersEvent {
  const SearchUsersFetchRequest(this.users);

  final List<User>? users;

  @override
  List<Object?> get props => [users];
}

class SearchUsersFilterRequest extends SearchUsersEvent {
  const SearchUsersFilterRequest(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

class SearchSelectUserRequest extends SearchUsersEvent {
  const SearchSelectUserRequest(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}
