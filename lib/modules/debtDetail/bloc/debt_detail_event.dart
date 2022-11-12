part of 'debt_detail_bloc.dart';

abstract class DebtDetailEvent extends Equatable {
  const DebtDetailEvent();
}

class DebtDetailBudgetFetchRequest extends DebtDetailEvent {
  const DebtDetailBudgetFetchRequest({required this.budget});

  final Budget? budget;

  @override
  List<Object?> get props => [budget];
}

class DebtDetailRemovedMovement extends DebtDetailEvent {
  const DebtDetailRemovedMovement({
    required this.removeMovement,
  });

  final Movement? removeMovement;

  @override
  List<Object?> get props => [removeMovement];
}

class DebtDetailMarkPayedMovement extends DebtDetailEvent {
  const DebtDetailMarkPayedMovement({
    required this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}

class DebtDetailEditMovement extends DebtDetailEvent {
  const DebtDetailEditMovement({
    required this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}

class DebtDetailAddDailyPayedMovement extends DebtDetailEvent {
  const DebtDetailAddDailyPayedMovement({
    required this.value,
    required this.movement,
  });

  final DebtDaily? value;
  final Movement? movement;

  @override
  List<Object?> get props => [value, movement];
}
