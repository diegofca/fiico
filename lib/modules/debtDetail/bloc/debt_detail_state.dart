part of 'debt_detail_bloc.dart';

enum DebtDetailStatus { init, loading }

class DebtDetailState extends Equatable {
  const DebtDetailState({
    this.status = DebtDetailStatus.init,
    this.removedMovement,
    this.updatedMovement,
    this.budget,
    this.payed,
  });

  final DebtDetailStatus status;
  final Budget? budget;
  final Movement? removedMovement;
  final Movement? updatedMovement;
  final bool? payed;

  bool get isDeletedMovement => removedMovement != null;
  bool get isPayed => payed != null;
  bool get isModify => updatedMovement != null;

  @override
  List<Object?> get props => [status, budget, removedMovement, payed];

  DebtDetailState copyWith({
    DebtDetailStatus? status,
    Budget? budget,
    Movement? removedMovement,
    Movement? updatedMovement,
    bool? payed,
  }) {
    return DebtDetailState(
      status: status ?? this.status,
      budget: budget ?? this.budget,
      removedMovement: removedMovement ?? this.removedMovement,
      updatedMovement: updatedMovement,
      payed: payed,
    );
  }
}
