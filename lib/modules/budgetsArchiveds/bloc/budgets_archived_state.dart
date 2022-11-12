part of 'budgets_archived_bloc.dart';

enum BudgetsArchivedStatus {
  waiting,
}

class BudgetsArchivedState extends Equatable {
  const BudgetsArchivedState({
    this.status = BudgetsArchivedStatus.waiting,
    this.budgetSelected,
    this.budgets,
  });

  final BudgetsArchivedStatus status;
  final Stream<List<Budget>>? budgets;
  final int? budgetSelected;

  @override
  List<Object> get props => [status, budgets ?? []];

  BudgetsArchivedState copyWith({
    BudgetsArchivedStatus? status,
    Stream<List<Budget>>? budgets,
    int? budgetSelected,
  }) {
    return BudgetsArchivedState(
      status: status ?? this.status,
      budgets: budgets ?? this.budgets,
      budgetSelected: budgetSelected ?? this.budgetSelected,
    );
  }
}
