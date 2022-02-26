part of 'budget_detail_bloc.dart';

enum BudgetDetailStatus { loading, success, failed }

class BudgetDetailState extends Equatable {
  const BudgetDetailState({
    this.status = BudgetDetailStatus.success,
    this.movementAdded,
    this.budget,
  });

  final BudgetDetailStatus status;
  final Stream<Budget>? budget;
  final Movement? movementAdded;

  @override
  List<Object> get props => [status];

  BudgetDetailState copyWith({
    BudgetDetailStatus? status,
    Stream<Budget>? budget,
    Movement? movementAdded,
  }) {
    return BudgetDetailState(
      movementAdded: movementAdded ?? this.movementAdded,
      status: status ?? this.status,
      budget: budget ?? this.budget,
    );
  }
}
