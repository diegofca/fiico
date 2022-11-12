import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/budgetDetail/repository/budget_detail_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

part 'budget_detail_event.dart';
part 'budget_detail_state.dart';

class BudgetDetailBloc extends Bloc<BudgetDetailEvent, BudgetDetailState> {
  BudgetDetailBloc(this.repository) : super(const BudgetDetailState()) {
    on<BudgetDetailFetchRequest>(_mapBudgetsToState);
    on<BudgetDetailDeleteRequest>(_mapDeleteBudgetToState);
    on<BudgetDetailArchiveRequest>(_mapArchiveBudgetToState);
    on<BudgetDetailRecoverRequest>(_mapRecoverBudgetToState);
    on<BudgetDetailRemoveUserRequest>(_mapRemoveToUserToState);
    on<BudgetDetailMovementAddedRequest>(_mapAddedMovementToState);
    on<BudgetDetailMovementRemoveRequest>(_mapRemoveMovementToState);
    on<BudgetUpdateDetailRequest>(_mapUpdateBudgetToState);
    on<BudgetUpdateDetailUsersSelected>(_mapChangeUsersToState);
    on<BudgetUpdateDropdownHistoryIndexRequest>(_mapChangeDropdownIndexToState);
    on<BudgetSegmentIndexRequest>(_mapChangeSegmentIndexToState);
  }

  final BudgetDetailRepository repository;

  void _mapBudgetsToState(
    BudgetDetailFetchRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    final userID = event.budget?.getPropertiedID();
    emit(state.copyWith(
      status: BudgetDetailStatus.success,
      budget: repository.getBudget(userID),
    ));
  }

  void _mapArchiveBudgetToState(
    BudgetDetailArchiveRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      await repository.archiveBudget(event.budget);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        deleteBudget: event.budget,
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }

  void _mapDeleteBudgetToState(
    BudgetDetailDeleteRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      await repository.deleteBudget(event.budget);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        deleteBudget: event.budget,
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }

  void _mapRecoverBudgetToState(
    BudgetDetailRecoverRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      await repository.recoverBudget(event.budget);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        deleteBudget: event.budget,
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }

  void _mapAddedMovementToState(
    BudgetDetailMovementAddedRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      await repository.addNewMovement(event.newMovement, event.budget);
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
    try {
      await repository.deleteMovement(event.movement, event.budget);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        movementAdded: event.movement,
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }

  void _mapUpdateBudgetToState(
    BudgetUpdateDetailRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    try {
      final userID = event.budget.getPropertiedID();
      await repository.updateBudget(event.budget);
      emit(state.copyWith(
        status: BudgetDetailStatus.success,
        budget: repository.getBudget(userID),
      ));
    } catch (_) {
      emit(state.copyWith(status: BudgetDetailStatus.failed));
    }
  }

  void _mapRemoveToUserToState(
    BudgetDetailRemoveUserRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));

    var budget = event.budget;
    for (var u in budget.users ?? []) {
      final isEntry = event.users?.firstWhereOrNull((e) => e.id == u.id);
      if (isEntry == null) {
        await repository.removeUserToBudget(u, budget);
      }
    }

    budget = budget.copyWith(users: event.users);
    await repository.updateBudget(budget);
    emit(state.copyWith(
      status: BudgetDetailStatus.success,
      deleteBudget: budget,
    ));
  }

  void _mapChangeUsersToState(
    BudgetUpdateDetailUsersSelected event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));

    var budget = event.budget;
    final userID = budget.getPropertiedID();

    for (var u in budget.users ?? []) {
      final isEntry = event.users?.firstWhereOrNull((e) => e.id == u.id);
      if (isEntry == null) {
        await repository.removeUserToBudget(u, budget);
      }
    }

    budget = budget.copyWith(users: event.users);
    await repository.updateBudget(budget);
    emit(state.copyWith(
      status: BudgetDetailStatus.success,
      budget: repository.getBudget(userID),
    ));
  }

  void _mapChangeDropdownIndexToState(
    BudgetUpdateDropdownHistoryIndexRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    emit(state.copyWith(
      status: BudgetDetailStatus.success,
      dropdownIndex: event.index,
    ));
  }

  void _mapChangeSegmentIndexToState(
    BudgetSegmentIndexRequest event,
    Emitter<BudgetDetailState> emit,
  ) async {
    emit(state.copyWith(status: BudgetDetailStatus.loading));
    emit(state.copyWith(
      status: BudgetDetailStatus.success,
      segmentIndex: event.index,
    ));
  }
}
