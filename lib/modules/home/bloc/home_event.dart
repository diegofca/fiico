part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeBudgetsFetchRequest extends HomeEvent {
  const HomeBudgetsFetchRequest({required this.uID});

  final int uID;

  @override
  List<Object?> get props => [uID];
}

class HomeBudgetSelected extends HomeEvent {
  const HomeBudgetSelected({
    this.budget,
  });

  final int? budget;

  @override
  List<Object?> get props => [budget];
}
