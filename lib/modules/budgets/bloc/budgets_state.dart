part of 'budgets_bloc.dart';

enum BudgetsStatus {
  waiting,
}

class BudgetsState extends Equatable {
  const BudgetsState({
    this.status = BudgetsStatus.waiting,
    this.budgetSelected,
    this.budgets,
  });

  final BudgetsStatus status;
  final Stream<List<Budget>>? budgets;
  final int? budgetSelected;

  @override
  List<Object> get props => [status, budgets ?? []];

  BudgetsState copyWith({
    BudgetsStatus? status,
    Stream<List<Budget>>? budgets,
    int? budgetSelected,
  }) {
    return BudgetsState(
      status: status ?? this.status,
      budgets: budgets ?? this.budgets,
      budgetSelected: budgetSelected ?? this.budgetSelected,
    );
  }
}
