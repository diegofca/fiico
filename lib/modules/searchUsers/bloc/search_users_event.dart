part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class SearchUsersFetchRequest extends SearchUsersEvent {
  const SearchUsersFetchRequest(this.users);

  final List<FiicoUser>? users;

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

  final FiicoUser user;

  @override
  List<Object?> get props => [user];
}

class SearchSelectSegment extends SearchUsersEvent {
  const SearchSelectSegment({
    required this.user,
  });

  final FiicoUser user;

  @override
  List<Object?> get props => [user];
}
