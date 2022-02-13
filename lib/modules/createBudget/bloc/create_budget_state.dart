// ignore_for_file: must_be_immutable

part of 'create_budget_bloc.dart';

enum CreateBudgetStatus {
  success,
  loading,
}

class CreateBudgetState extends Equatable {
  CreateBudgetState({
    this.status = CreateBudgetStatus.success,
    this.currencySelected,
    this.movements = const [],
    this.users,
    this.addedMovement,
    this.removedMovement,
  });

  final CreateBudgetStatus status;
  final Currency? currencySelected;
  final Movement? addedMovement;
  final Movement? removedMovement;
  final List<User>? users;
  List<Movement> movements;

  List<Movement> get entrys =>
      movements.where((e) => e.getType() == MovementType.ENTRY).toList();
  List<Movement> get debts =>
      movements.where((e) => e.getType() == MovementType.DEBT).toList();

  @override
  List<Object> get props => [status];

  CreateBudgetState copyWith({
    CreateBudgetStatus? status,
    Currency? currencySelected,
    Movement? addedMovement,
    Movement? removedMovement,
    List<User>? users,
  }) {
    var newMovements = movements.toList();
    if (addedMovement != null) {
      newMovements.add(addedMovement);
    }

    if (removedMovement != null) {
      newMovements.remove(removedMovement);
    }

    return CreateBudgetState(
      status: status ?? this.status,
      currencySelected: currencySelected ?? this.currencySelected,
      addedMovement: addedMovement ?? this.addedMovement,
      removedMovement: removedMovement ?? this.removedMovement,
      users: users ?? this.users,
      movements: newMovements,
    );
  }
}
