import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/budgetDetail/repository/budget_detail_repository.dart';
import 'package:equatable/equatable.dart';

part 'budget_detail_event.dart';
part 'budget_detail_state.dart';

class BudgetDetailBloc extends Bloc<BudgetDetailEvent, BudgetDetailState> {
  BudgetDetailBloc(this.repository) : super(const BudgetDetailState()) {
    on<BudgetDetailFetchRequest>(_mapBudgetsToState);
    on<BudgetDetailMovementAddedRequest>(_mapAddedMovementToState);
    on<BudgetDetailMovementRemoveRequest>(_mapRemoveMovementToState);
  }

  final BudgetDetailRepository repository;

  void _mapBudgetsToState(
    BudgetDetailFetchRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(
      status: BudgetDetailStatus.success,
      budget: repository.getBudget(),
    ));
  }

  void _mapAddedMovementToState(
    BudgetDetailMovementAddedRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      await repository.addNewMovement(event.newMovement);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        movementAdded: event.newMovement,
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }

  void _mapRemoveMovementToState(
    BudgetDetailMovementRemoveRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      await repository.deleteMovement(event.movement);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        movementAdded: event.movement,
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }
}
