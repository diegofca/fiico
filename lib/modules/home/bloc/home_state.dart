part of 'home_bloc.dart';

enum HomeStatus { init, loading, success }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.init,
    this.budgetSelected,
    this.removedMovement,
    this.showTutorial,
    this.budgets,
    this.filter,
  });

  final HomeStatus status;
  final Stream<List<Budget>>? budgets;
  final Budget? budgetSelected;
  final Movement? removedMovement;
  final int? filter;
  final bool? showTutorial;

  @override
  List<Object?> get props =>
      [status, budgets, budgetSelected, removedMovement, showTutorial, filter];

  HomeState copyWith({
    HomeStatus? status,
    Stream<List<Budget>>? budgets,
    Budget? budgetSelected,
    Movement? removedMovement,
    bool? showTutorial,
    int? filter,
  }) {
    return HomeState(
      status: status ?? this.status,
      budgets: budgets ?? this.budgets,
      budgetSelected: budgetSelected ?? this.budgetSelected,
      removedMovement: removedMovement ?? this.removedMovement,
      showTutorial: showTutorial ?? this.showTutorial,
      filter: filter ?? this.filter,
    );
  }
}
