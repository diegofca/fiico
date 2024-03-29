import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/createBudget/repository/create_budget_repository.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';

part 'create_budget_state.dart';
part 'create_budget_event.dart';

class CreateBudgetBloc extends Bloc<CreateBudgetEvent, CreateBudgetState> {
  CreateBudgetBloc(this.repository) : super(CreateBudgetState()) {
    // - Observers
    on<CreateBudgetInfoSelected>(_mapBudgetInfoSelectedState);
    on<CreateBudgetAddedmovement>(_mapAddedmovementToState);
    on<CreateBudgetRemovedMovement>(_mapRemovedMovementToState);
    on<CreateBudgetSearchUsersSelected>(_mapUsersSearchToState);
    on<CreateBudgetAdded>(_mapAddedBudgetToState);
  }

  final CreateBudgetRepository repository;

  void _mapAddedBudgetToState(
    CreateBudgetAdded event,
    Emitter<CreateBudgetState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateBudgetStatus.loading));
      await repository.addNewBudget(event.budget);
      emit(state.copyWith(
        status: CreateBudgetStatus.success,
        addedBudgetID: event.budget.id,
      ));
    } catch (_) {
      emit(state.copyWith(status: CreateBudgetStatus.failure));
    }
  }

  void _mapBudgetInfoSelectedState(
    CreateBudgetInfoSelected event,
    Emitter<CreateBudgetState> emit,
  ) async {
    emit(state.copyWith(status: CreateBudgetStatus.loading));
    emit(state.copyWith(
      status: CreateBudgetStatus.success,
      currencySelected: event.currency,
      isCycle: event.isCycle,
      initDate: event.initDate,
      finishDate: event.finishDate,
      isDailyDebt: event.isDailyDebt,
      duration: event.duration,
      cycle: event.cycle,
      icon: event.icon,
    ));
  }

  void _mapAddedmovementToState(
    CreateBudgetAddedmovement event,
    Emitter<CreateBudgetState> emit,
  ) async {
    emit(state.copyWith(status: CreateBudgetStatus.loading));
    emit(state.copyWith(
      status: CreateBudgetStatus.success,
      addedMovement: event.movement,
    ));
  }

  void _mapRemovedMovementToState(
    CreateBudgetRemovedMovement event,
    Emitter<CreateBudgetState> emit,
  ) async {
    emit(state.copyWith(status: CreateBudgetStatus.loading));
    emit(state.copyWith(
      status: CreateBudgetStatus.success,
      removedMovement: event.movement,
    ));
  }

  void _mapUsersSearchToState(
    CreateBudgetSearchUsersSelected event,
    Emitter<CreateBudgetState> emit,
  ) async {
    emit(state.copyWith(status: CreateBudgetStatus.loading));
    emit(state.copyWith(
      status: CreateBudgetStatus.success,
      users: event.users,
    ));
  }
}
