import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgetsArchiveds/repository/budgets_archived_repository.dart';
import 'package:equatable/equatable.dart';

part 'budgets_archived_event.dart';
part 'budgets_archived_state.dart';

class BudgetsArchivedBloc
    extends Bloc<BudgetsArchivedEvent, BudgetsArchivedState> {
  BudgetsArchivedBloc(this.repository) : super(const BudgetsArchivedState()) {
    on<BudgetsArchivedFetchRequest>(_mapBoardsToState);
    on<BudgetsArchivedSelected>(_mapSelectedBoardToState);
  }

  final BudgetsArchivedRepository repository;

  void _mapBoardsToState(
    BudgetsArchivedFetchRequest event,
    Emitter<BudgetsArchivedState> emit,
  ) async {
    emit(state.copyWith(
      status: BudgetsArchivedStatus.waiting,
      budgets: repository.budgets(event.uID),
    ));
  }

  void _mapSelectedBoardToState(
    BudgetsArchivedSelected event,
    Emitter<BudgetsArchivedState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: BudgetsArchivedStatus.waiting,
      budgets: repository.budgets(user?.id),
      budgetSelected: event.budget,
    ));
  }
}
