import 'package:bloc/bloc.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/createBudget/repository/create_budget_repository.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';

part 'create_budget_state.dart';
part 'create_budget_event.dart';

class CreateBudgetBloc extends Bloc<CreateBudgetEvent, CreateBudgetState> {
  CreateBudgetBloc(this.repository) : super(CreateBudgetState()) {
    on<CreateBudgetCurrencySelected>(
      _mapCurrencySelectedState,
    );
    on<CreateBudgetAddedmovement>(
      _mapAddedmovementToState,
    );
    on<CreateBudgetRemovedMovement>(
      _mapRemovedMovementToState,
    );
    on<CreateBudgetSearchUsersSelected>(
      _mapUsersSearchToState,
    );
  }

  final CreateBudgetRepository repository;

  void _mapCurrencySelectedState(
    CreateBudgetCurrencySelected event,
    Emitter<CreateBudgetState> emit,
  ) async {
    emit(state.copyWith(status: CreateBudgetStatus.loading));
    emit(state.copyWith(
      status: CreateBudgetStatus.success,
      currencySelected: event.currency,
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
    emit(state.copyWith(
      status: CreateBudgetStatus.loading,
      users: event.users,
    ));
  }
}