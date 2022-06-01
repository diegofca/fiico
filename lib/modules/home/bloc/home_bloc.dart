import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
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
    on<HomeShowedTutorial>(_mapShowedTutorialToState);
  }

  final HomeRepository repository;

  void _mapBudgetsToState(
    HomeBudgetsFetchRequest event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(event.uID),
    ));
  }

  void _mapSelectedBudgetToState(
    HomeBudgetSelected event,
    Emitter<HomeState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(user?.id),
      budgetSelected: event.budget,
    ));
  }

  void _mapSelectedFilterToState(
    HomeBudgetSelectedFilter event,
    Emitter<HomeState> emit,
  ) async {
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(user?.id),
      filter: event.filter,
    ));
  }

  void _mapRemovedMovementToState(
    HomeBudgetRemovedMovement event,
    Emitter<HomeState> emit,
  ) async {
    await repository.deleteMovement(event.movement, state.budgetSelected);
    final user = await Preferences.get.getUser();
    emit(state.copyWith(
      status: HomeStatus.init,
      removedMovement: event.movement,
      budgets: repository.budgets(user?.id),
    ));
  }

  void _mapShowedTutorialToState(
    HomeShowedTutorial event,
    Emitter<HomeState> emit,
  ) async {
    var user = await Preferences.get.getUser();
    user?.showTutorial = event.showed ?? false;
    Preferences.get.saveUser(user);

    await repository.showTutorial(user?.id);

    emit(state.copyWith(
      status: HomeStatus.init,
      budgets: repository.budgets(user?.id),
      showTutorial: event.showed,
    ));
  }
}
