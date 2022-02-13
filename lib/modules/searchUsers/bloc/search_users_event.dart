part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class SearchUsersFetchRequest extends SearchUsersEvent {
  const SearchUsersFetchRequest();

  @override
  List<Object?> get props => [];
}

class SearchUsersFilterRequest extends SearchUsersEvent {
  const SearchUsersFilterRequest(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
