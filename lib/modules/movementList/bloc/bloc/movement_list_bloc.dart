import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/budgetDetail/repository/budget_detail_repository.dart';
import 'package:equatable/equatable.dart';

part 'movement_list_event.dart';
part 'movement_list_state.dart';

class MovementListBloc extends Bloc<MovementListEvent, MovementListState> {
  MovementListBloc(this.repository) : super(const MovementListState()) {
    on<MovementListFetchRequest>(_mapBudgetsToState);
    on<MovementListSelectedTypeRequest>(_mapChangeMovementTypeToState);
    on<MovementListMovementAddedRequest>(_mapAddedMovementToState);
  }

  final BudgetDetailRepository repository;

  void _mapBudgetsToState(
    MovementListFetchRequest event,
    Emitter<MovementListState> emit,
  ) async {
    final userID = event.budget?.getPropertiedID();
    emit(state.copyWith(
      status: MovementListStatus.init,
      budget: repository.getBudget(userID),
    ));
  }

  void _mapChangeMovementTypeToState(
    MovementListSelectedTypeRequest event,
    Emitter<MovementListState> emit,
  ) async {
    emit(state.copyWith(status: MovementListStatus.loading));
    emit(state.copyWith(
      status: MovementListStatus.init,
      value: event.value,
    ));
  }

  void _mapAddedMovementToState(
    MovementListMovementAddedRequest event,
    Emitter<MovementListState> emit,
  ) async {
    emit(state.copyWith(status: MovementListStatus.loading));
    try {
      await repository.addNewMovement(event.newMovement, event.budget);
      emit(state.copyWith(
        status: MovementListStatus.success,
        movementAdded: event.newMovement,
      ));
    } catch (_) {
      emit(state.copyWith(status: MovementListStatus.failed));
    }
  }
}
