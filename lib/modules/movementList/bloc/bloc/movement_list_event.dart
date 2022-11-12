part of 'movement_list_bloc.dart';

abstract class MovementListEvent extends Equatable {
  const MovementListEvent();
}

class MovementListFetchRequest extends MovementListEvent {
  const MovementListFetchRequest({required this.budget});

  final Budget? budget;

  @override
  List<Object?> get props => [budget];
}

class MovementListSelectedTypeRequest extends MovementListEvent {
  const MovementListSelectedTypeRequest({required this.value});

  final int? value;

  @override
  List<Object?> get props => [value];
}

class MovementListMovementAddedRequest extends MovementListEvent {
  const MovementListMovementAddedRequest({
    required this.newMovement,
    required this.budget,
  });

  final Movement newMovement;
  final Budget budget;

  @override
  List<Object?> get props => [newMovement, budget];
}
