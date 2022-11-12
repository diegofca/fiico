part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchUsersRequest extends SearchEvent {
  const SearchUsersRequest(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class SearchSelectSegment extends SearchEvent {
  const SearchSelectSegment({this.index});

  final int? index;

  @override
  List<Object?> get props => [index];
}

class SendRequestFriendRequest extends SearchEvent {
  const SendRequestFriendRequest({
    this.user,
  });

  final FiicoUser? user;

  @override
  List<Object?> get props => [user];
}
