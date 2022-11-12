part of 'movement_list_bloc.dart';

enum MovementListStatus { init, loading, success, failed }

class MovementListState extends Equatable {
  const MovementListState({
    this.status = MovementListStatus.init,
    this.budget,
    this.movementAdded,
    this.value = 4,
  });

  final MovementListStatus status;
  final Stream<Budget>? budget;
  final Movement? movementAdded;
  final int value;

  @override
  List<Object?> get props => [status, value];

  MovementListState copyWith({
    MovementListStatus? status,
    Stream<Budget>? budget,
    Movement? movementAdded,
    int? value,
  }) {
    return MovementListState(
      status: status ?? this.status,
      budget: budget ?? this.budget,
      value: value ?? this.value,
    );
  }
}
