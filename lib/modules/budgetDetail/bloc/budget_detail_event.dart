part of 'budget_detail_bloc.dart';

abstract class BudgetDetailEvent extends Equatable {
  const BudgetDetailEvent();
}

class BudgetDetailFetchRequest extends BudgetDetailEvent {
  const BudgetDetailFetchRequest({required this.budget});

  final Budget? budget;

  @override
  List<Object?> get props => [budget];
}

class BudgetDetailDeleteRequest extends BudgetDetailEvent {
  const BudgetDetailDeleteRequest({required this.budget});

  final Budget budget;

  @override
  List<Object?> get props => [budget];
}

class BudgetDetailMovementAddedRequest extends BudgetDetailEvent {
  const BudgetDetailMovementAddedRequest({
    required this.newMovement,
    required this.budget,
  });

  final Movement newMovement;
  final Budget budget;

  @override
  List<Object?> get props => [newMovement, budget];
}

class BudgetDetailMovementRemoveRequest extends BudgetDetailEvent {
  const BudgetDetailMovementRemoveRequest({
    required this.movement,
    required this.budget,
  });

  final Movement movement;
  final Budget budget;

  @override
  List<Object?> get props => [movement, budget];
}

class BudgetUpdateDetailRequest extends BudgetDetailEvent {
  const BudgetUpdateDetailRequest({required this.budget});

  final Budget budget;

  @override
  List<Object?> get props => [budget];
}

class BudgetUpdateDetailUsersSelected extends BudgetDetailEvent {
  const BudgetUpdateDetailUsersSelected({
    required this.users,
    required this.budget,
  });

  final List<FiicoUser>? users;
  final Budget budget;

  @override
  List<Object?> get props => [users, budget];
}
