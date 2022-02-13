part of 'home_bloc.dart';

enum HomeStatus {
  waiting,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.waiting,
    this.budgetSelected,
    this.budgets,
  });

  final HomeStatus status;
  final Stream<List<Budget>>? budgets;
  final Budget? budgetSelected;

  @override
  List<Object> get props => [status, budgets ?? []];

  HomeState copyWith({
    HomeStatus? status,
    Stream<List<Budget>>? budgets,
    Budget? budgetSelected,
  }) {
    return HomeState(
      status: status ?? this.status,
      budgets: budgets ?? this.budgets,
      budgetSelected: budgetSelected ?? this.budgetSelected,
    );
  }
}
