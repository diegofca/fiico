part of 'home_bloc.dart';

enum HomeStatus { init, loading }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.init,
    this.budgetSelected,
    this.removedMovement,
    this.budgets,
    this.filter,
  });

  final HomeStatus status;
  final Stream<List<Budget>>? budgets;
  final Budget? budgetSelected;
  final Movement? removedMovement;
  final int? filter;

  @override
  List<Object> get props => [status, budgets ?? []];

  HomeState copyWith({
    HomeStatus? status,
    Stream<List<Budget>>? budgets,
    Budget? budgetSelected,
    Movement? removedMovement,
    int? filter,
  }) {
    return HomeState(
      status: status ?? this.status,
      budgets: budgets ?? this.budgets,
      budgetSelected: budgetSelected ?? this.budgetSelected,
      removedMovement: removedMovement ?? this.removedMovement,
      filter: filter ?? this.filter,
    );
  }
}
