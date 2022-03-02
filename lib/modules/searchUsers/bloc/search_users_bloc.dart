import 'package:bloc/bloc.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/repository/search_users_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_users_state.dart';
part 'search_users_event.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  SearchUsersBloc(this.repository) : super(const SearchUsersState()) {
    on<SearchUsersFetchRequest>(_mapUsersSearchToState);
    on<SearchUsersFilterRequest>(_mapUsersSearchFiltersToState);
  }

  final SearchUsersRepository repository;

  void _mapUsersSearchToState(
    SearchUsersFetchRequest event,
    Emitter<SearchUsersState> emit,
  ) async {
    emit(state.copyWith(
      status: SearchUsersStatus.success,
      users: repository.searchUsers(),
    ));
  }

  void _mapUsersSearchFiltersToState(
    SearchUsersFilterRequest event,
    Emitter<SearchUsersState> emit,
  ) async {
    emit(state.copyWith(status: SearchUsersStatus.searching));
    emit(state.copyWith(
      status: SearchUsersStatus.success,
      users: repository.searchUsers(),
      query: event.query,
    ));
  }
}
