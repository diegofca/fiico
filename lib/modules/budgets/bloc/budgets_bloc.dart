import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'budgets_event.dart';
part 'budgets_state.dart';

class BudgetsBloc extends Bloc<BudgetsEvent, BudgetsState> {
  BudgetsBloc(this.repository) : super(const BudgetsState()) {
    on<BudgetsFetchRequest>(
      _mapBoardsToState,
    );

    on<BudgetsSelected>(
      _mapSelectedBoardToState,
    );
  }

  final HomeRepository repository;

  void _mapBoardsToState(
    BudgetsFetchRequest event,
    Emitter<BudgetsState> emit,
  ) async {
    emit(state.copyWith(
      status: BudgetsStatus.waiting,
      budgets: repository.budgets(event.uID),
    ));
  }

  void _mapSelectedBoardToState(
    BudgetsSelected event,
    Emitter<BudgetsState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: BudgetsStatus.waiting,
      budgets: repository.budgets(user?.id),
      budgetSelected: event.budget,
    ));
  }
}
