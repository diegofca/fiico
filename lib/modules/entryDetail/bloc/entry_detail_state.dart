part of 'entry_detail_bloc.dart';

enum EntryDetailStatus { init, loading }

class EntryDetailState extends Equatable {
  const EntryDetailState({
    this.status = EntryDetailStatus.init,
    this.removedMovement,
    this.updatedMovement,
    this.budget,
    this.payed,
  });

  final EntryDetailStatus status;
  final Budget? budget;
  final Movement? removedMovement;
  final Movement? updatedMovement;
  final bool? payed;

  bool get isDeletedMovement => removedMovement != null;
  bool get isPayed => payed != null;
  bool get isModify => updatedMovement != null;

  @override
  List<Object?> get props => [status, budget, isDeletedMovement, payed];

  EntryDetailState copyWith({
    EntryDetailStatus? status,
    Budget? budget,
    Movement? removedMovement,
    Movement? updatedMovement,
    bool? payed,
  }) {
    return EntryDetailState(
      status: status ?? this.status,
      budget: budget ?? this.budget,
      removedMovement: removedMovement ?? this.removedMovement,
      updatedMovement: updatedMovement,
      payed: payed,
    );
  }
}
