part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeBudgetsFetchRequest extends HomeEvent {
  const HomeBudgetsFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}

class HomeBudgetSelected extends HomeEvent {
  const HomeBudgetSelected({
    this.budget,
  });

  final Budget? budget;

  @override
  List<Object?> get props => [budget];
}

class HomeBudgetSelectedFilter extends HomeEvent {
  const HomeBudgetSelectedFilter({
    this.filter,
  });

  final int? filter;

  @override
  List<Object?> get props => [filter];
}

class HomeBudgetRemovedMovement extends HomeEvent {
  const HomeBudgetRemovedMovement({
    this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}

class HomeShowedTutorial extends HomeEvent {
  const HomeShowedTutorial({
    this.showed,
  });

  final bool? showed;

  @override
  List<Object?> get props => [showed];
}
