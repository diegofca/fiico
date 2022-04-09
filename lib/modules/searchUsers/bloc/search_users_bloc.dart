import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/repository/search_users_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_users_state.dart';
part 'search_users_event.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  SearchUsersBloc(this.repository) : super(const SearchUsersState()) {
    on<SearchUsersFetchRequest>(_mapUsersSearchToState);
    on<SearchUsersFilterRequest>(_mapUsersSearchFiltersToState);
    on<SearchSelectUserRequest>(_mapSelectedUserToState);
  }

  final SearchUsersRepository repository;

  void _mapUsersSearchToState(
    SearchUsersFetchRequest event,
    Emitter<SearchUsersState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: SearchUsersStatus.success,
      users: repository.searchUsers(user?.id),
      selectedUsers: event.users,
    ));
  }

  void _mapUsersSearchFiltersToState(
    SearchUsersFilterRequest event,
    Emitter<SearchUsersState> emit,
  ) async {
    emit(state.copyWith(status: SearchUsersStatus.searching));
    emit(state.copyWith(
      status: SearchUsersStatus.success,
      query: event.query,
    ));
  }

  void _mapSelectedUserToState(
    SearchSelectUserRequest event,
    Emitter<SearchUsersState> emit,
  ) async {
    emit(state.copyWith(status: SearchUsersStatus.loading));

    final _users = state.selectedUsers?.toList() ?? [];
    if (_users.contains(event.user)) {
      _users.remove(event.user);
    } else {
      _users.add(event.user);
    }

    emit(state.copyWith(
      status: SearchUsersStatus.success,
      selectedUsers: _users,
    ));
  }
}
