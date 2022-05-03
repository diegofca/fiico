part of 'budget_detail_bloc.dart';

enum BudgetDetailStatus { loading, success, failed }

class BudgetDetailState extends Equatable {
  const BudgetDetailState({
    this.status = BudgetDetailStatus.success,
    this.movementAdded,
    this.deleteBudget,
    this.dropdownIndex = 0,
    this.segmentIndex = 0,
    this.budget,
  });

  final BudgetDetailStatus status;
  final Stream<Budget>? budget;
  final Movement? movementAdded;
  final Budget? deleteBudget;
  final int? dropdownIndex;
  final int? segmentIndex;

  bool get isDeletedBudget => deleteBudget != null;

  @override
  List<Object?> get props => [
        status,
        budget,
        movementAdded,
        deleteBudget,
        dropdownIndex,
        segmentIndex,
      ];

  BudgetDetailState copyWith({
    BudgetDetailStatus? status,
    Stream<Budget>? budget,
    Movement? movementAdded,
    Budget? deleteBudget,
    int? dropdownIndex,
    int? segmentIndex,
  }) {
    return BudgetDetailState(
      movementAdded: movementAdded ?? this.movementAdded,
      deleteBudget: deleteBudget ?? this.deleteBudget,
      dropdownIndex: dropdownIndex ?? this.dropdownIndex,
      segmentIndex: segmentIndex ?? this.segmentIndex,
      status: status ?? this.status,
      budget: budget ?? this.budget,
    );
  }
}
