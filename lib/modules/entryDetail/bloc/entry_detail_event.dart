part of 'entry_detail_bloc.dart';

abstract class EntryDetailEvent extends Equatable {
  const EntryDetailEvent();
}

class EntryDetailBudgetFetchRequest extends EntryDetailEvent {
  const EntryDetailBudgetFetchRequest({required this.budget});

  final Budget? budget;

  @override
  List<Object?> get props => [budget];
}

class EntryDetailRemovedMovement extends EntryDetailEvent {
  const EntryDetailRemovedMovement({
    this.removeMovement,
  });

  final Movement? removeMovement;

  @override
  List<Object?> get props => [removeMovement];
}

class EntryDetailMarkPayedMovement extends EntryDetailEvent {
  const EntryDetailMarkPayedMovement({
    required this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}

class EntryDetailEditMovement extends EntryDetailEvent {
  const EntryDetailEditMovement({
    required this.movement,
  });

  final Movement? movement;

  @override
  List<Object?> get props => [movement];
}
