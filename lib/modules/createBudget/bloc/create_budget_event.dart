part of 'create_budget_bloc.dart';

abstract class CreateBudgetEvent extends Equatable {
  const CreateBudgetEvent();
}

class CreateBudgetInfoSelected extends CreateBudgetEvent {
  const CreateBudgetInfoSelected({
    this.currency,
    this.isCycle,
    this.cycle,
    this.duration,
    this.initDate,
    this.finishDate,
    this.icon,
  });

  final Currency? currency;
  final bool? isCycle;
  final int? cycle;
  final int? duration;
  final Timestamp? initDate;
  final Timestamp? finishDate;
  final FiicoIcon? icon;

  @override
  List<Object?> get props =>
      [currency, isCycle, cycle, duration, initDate, finishDate, icon];
}

class CreateBudgetAdded extends CreateBudgetEvent {
  const CreateBudgetAdded({
    required this.budget,
  });

  final Budget budget;

  @override
  List<Object?> get props => [budget];
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

  final List<FiicoUser>? users;

  @override
  List<Object?> get props => [users];
}
