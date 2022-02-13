part of 'create_budget_bloc.dart';

abstract class CreateBudgetEvent extends Equatable {
  const CreateBudgetEvent();
}

class CreateBudgetCurrencySelected extends CreateBudgetEvent {
  const CreateBudgetCurrencySelected({
    this.currency,
  });

  final Currency? currency;

  @override
  List<Object?> get props => [currency];
}

class CreateBudgetAddedmovement extends CreateBudgetEvent {
  const CreateBudgetAddedmovement({
    this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}

class CreateBudgetRemovedMovement extends CreateBudgetEvent {
  const CreateBudgetRemovedMovement({
    this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}

class CreateBudgetSearchUsersSelected extends CreateBudgetEvent {
  const CreateBudgetSearchUsersSelected({
    this.users,
  });

  final List<User>? users;

  @override
  List<Object?> get props => [users];
}
