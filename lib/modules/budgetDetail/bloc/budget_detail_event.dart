part of 'budget_detail_bloc.dart';

abstract class BudgetDetailEvent extends Equatable {
  const BudgetDetailEvent();
}

class BudgetDetailFetchRequest extends BudgetDetailEvent {
  const BudgetDetailFetchRequest({required this.uID});

  final int uID;

  @override
  List<Object?> get props => [uID];
}

class BudgetDetailDeleteRequest extends BudgetDetailEvent {
  const BudgetDetailDeleteRequest({required this.budget});

  final Budget budget;

  @override
  List<Object?> get props => [budget];
}

class BudgetDetailMovementAddedRequest extends BudgetDetailEvent {
  const BudgetDetailMovementAddedRequest({required this.newMovement});

  final Movement newMovement;

  @override
  List<Object?> get props => [newMovement];
}

class BudgetDetailMovementRemoveRequest extends BudgetDetailEvent {
  const BudgetDetailMovementRemoveRequest({required this.movement});

  final Movement movement;

  @override
  List<Object?> get props => [movement];
}

class BudgetUpdateDetailRequest extends BudgetDetailEvent {
  const BudgetUpdateDetailRequest({required this.budget});

  final Budget budget;

  @override
  List<Object?> get props => [budget];
}
