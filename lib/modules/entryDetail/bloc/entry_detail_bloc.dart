import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/entryDetail/repository/entry_detail_repository.dart';
import 'package:equatable/equatable.dart';

part 'entry_detail_event.dart';
part 'entry_detail_state.dart';

class EntryDetailBloc extends Bloc<EntryDetailEvent, EntryDetailState> {
  EntryDetailBloc(this.repository) : super(const EntryDetailState()) {
    on<EntryDetailBudgetFetchRequest>(_mapBudgetToState);
    on<EntryDetailRemovedMovement>(_mapRemovedMovementToState);
    on<EntryDetailMarkPayedMovement>(_mapMarkPayedMovementToState);
    on<EntryDetailEditMovement>(_mapEditMovementToState);
  }

  final EntryDetailRepository repository;

  void _mapBudgetToState(
    EntryDetailBudgetFetchRequest event,
    Emitter<EntryDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntryDetailStatus.loading));
    emit(state.copyWith(
      status: EntryDetailStatus.init,
      budget: event.budget,
    ));
  }

  void _mapRemovedMovementToState(
    EntryDetailRemovedMovement event,
    Emitter<EntryDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntryDetailStatus.loading));
    await repository.deleteMovement(event.removeMovement, state.budget);
    emit(state.copyWith(
      status: EntryDetailStatus.init,
      removedMovement: event.removeMovement,
    ));
  }

  void _mapMarkPayedMovementToState(
    EntryDetailMarkPayedMovement event,
    Emitter<EntryDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntryDetailStatus.loading));
    await repository.markPayed(state.budget, event.movement);
    final movement = event.movement?.copyWith(paymentStatus: 'Payed');
    emit(state.copyWith(
      status: EntryDetailStatus.init,
      updatedMovement: movement,
      payed: true,
    ));
  }

  void _mapEditMovementToState(
    EntryDetailEditMovement event,
    Emitter<EntryDetailState> emit,
  ) async {
    emit(state.copyWith(status: EntryDetailStatus.loading));

    final budget = state.budget;
    await repository.updateMovement(event.movement, budget);

    emit(state.copyWith(
      status: EntryDetailStatus.init,
      updatedMovement: event.movement,
    ));
  }
}
