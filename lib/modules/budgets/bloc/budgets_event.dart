part of 'budgets_bloc.dart';

abstract class BudgetsEvent extends Equatable {
  const BudgetsEvent();
}

class BudgetsFetchRequest extends BudgetsEvent {
  const BudgetsFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}

class BudgetsSelected extends BudgetsEvent {
  const BudgetsSelected({
    this.budget,
  });

  final int? budget;

  @override
  List<Object?> get props => [budget];
}
