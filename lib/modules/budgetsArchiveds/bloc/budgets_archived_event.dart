part of 'budgets_archived_bloc.dart';

abstract class BudgetsArchivedEvent extends Equatable {
  const BudgetsArchivedEvent();
}

class BudgetsArchivedFetchRequest extends BudgetsArchivedEvent {
  const BudgetsArchivedFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}

class BudgetsArchivedSelected extends BudgetsArchivedEvent {
  const BudgetsArchivedSelected({
    this.budget,
  });

  final int? budget;

  @override
  List<Object?> get props => [budget];
}
