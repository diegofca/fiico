import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/search/repository/search_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(const SearchState()) {
    on<SearchUsersRequest>(_mapUsersSearchToState);
    on<SearchSelectSegment>(_mapSelectSegmentToState);
  }

  final SearchRepository repository;

  void _mapUsersSearchToState(
    SearchUsersRequest event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.searching));
    emit(state.copyWith(
      status: SearchStatus.success,
      users: repository.searchUsers(event.query),
      budgets: repository.searchBudgets(event.query),
      movements: repository.searchMovements(event.query),
      query: event.query,
    ));
  }

  void _mapSelectSegmentToState(
    SearchSelectSegment event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.searching));
    emit(state.copyWith(
      status: SearchStatus.success,
      index: event.index,
    ));
  }
}
