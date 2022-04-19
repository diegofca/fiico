import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/repository/debt_detail_repository.dart';
import 'package:equatable/equatable.dart';

part 'debt_detail_event.dart';
part 'debt_detail_state.dart';

class DebtDetailBloc extends Bloc<DebtDetailEvent, DebtDetailState> {
  DebtDetailBloc(this.repository) : super(const DebtDetailState()) {
    on<DebtDetailBudgetFetchRequest>(_mapBudgetToState);
    on<DebtDetailRemovedMovement>(_mapRemovedMovementToState);
    on<DebtDetailMarkPayedMovement>(_mapMarkPayedMovementToState);
    on<DebtDetailEditMovement>(_mapEditMovementToState);
  }

  final DebtDetailRepository repository;

  void _mapBudgetToState(
    DebtDetailBudgetFetchRequest event,
    Emitter<DebtDetailState> emit,
  ) async {
    emit(state.copyWith(status: DebtDetailStatus.loading));
    emit(state.copyWith(
      status: DebtDetailStatus.init,
      budget: event.budget,
    ));
  }

  void _mapRemovedMovementToState(
    DebtDetailRemovedMovement event,
    Emitter<DebtDetailState> emit,
  ) async {
    emit(state.copyWith(status: DebtDetailStatus.loading));
    await repository.deleteMovement(event.removeMovement, state.budget);
    emit(state.copyWith(
      status: DebtDetailStatus.init,
      removedMovement: event.removeMovement,
    ));
  }

  void _mapMarkPayedMovementToState(
    DebtDetailMarkPayedMovement event,
    Emitter<DebtDetailState> emit,
  ) async {
    emit(state.copyWith(status: DebtDetailStatus.loading));
    await repository.markPayed(state.budget, event.movement);
    final movement = event.movement?.copyWith(paymentStatus: 'Payed');
    emit(state.copyWith(
      status: DebtDetailStatus.init,
      updatedMovement: movement,
      payed: true,
    ));
  }

  void _mapEditMovementToState(
    DebtDetailEditMovement event,
    Emitter<DebtDetailState> emit,
  ) async {
    emit(state.copyWith(status: DebtDetailStatus.loading));

    final budget = state.budget;
    await repository.updateMovement(event.movement, budget);

    emit(state.copyWith(
      status: DebtDetailStatus.init,
      updatedMovement: event.movement,
    ));
  }
}
