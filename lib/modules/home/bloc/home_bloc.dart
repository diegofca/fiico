import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState()) {
    on<HomeBudgetsFetchRequest>(
      _mapBoardsToState,
    );

    on<HomeBudgetSelected>(
      _mapSelectedBoardToState,
    );
  }

  final HomeRepository repository;

  void _mapBoardsToState(
    HomeBudgetsFetchRequest event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.waiting,
      budgets: repository.budgets(),
    ));
  }

  void _mapSelectedBoardToState(
    HomeBudgetSelected event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.waiting,
      budgets: repository.budgets(),
      budgetSelected: event.budget,
    ));
  }
}
