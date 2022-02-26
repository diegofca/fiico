import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeBudgetsFetchRequest>(_mapBudgetsToState);
    on<HomeBudgetSelected>(_mapSelectedBudgetToState);
    on<HomeBudgetSelectedFilter>(_mapSelectedFilterToState);
    on<HomeBudgetRemovedMovement>(_mapRemovedMovementToState);
  }

  final HomeRepository repository;

  void _mapBudgetsToState(
    HomeBudgetsFetchRequest event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(),
    ));
  }

  void _mapSelectedBudgetToState(
    HomeBudgetSelected event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(),
      budgetSelected: event.budget,
    ));
  }

  void _mapSelectedFilterToState(
    HomeBudgetSelectedFilter event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(),
      filter: event.filter,
    ));
  }

  void _mapRemovedMovementToState(
    HomeBudgetRemovedMovement event,
    Emitter<HomeState> emit,
  ) async {
    final budgetID = state.budgetSelected?.id;
    await repository.deleteMovement(event.movement, budgetID);
    Timer(const Duration(seconds: 1), () {
      emit(state.copyWith(
        status: HomeStatus.init,
        removedMovement: event.movement,
        budgets: repository.budgets(),
      ));
    });
  }
}
