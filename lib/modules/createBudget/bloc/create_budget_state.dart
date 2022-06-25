// ignore_for_file: must_be_immutable

part of 'create_budget_bloc.dart';

enum CreateBudgetStatus {
  success,
  loading,
  failure,
}

class CreateBudgetState extends Equatable {
  CreateBudgetState({
    this.status = CreateBudgetStatus.success,
    this.currencySelected,
    this.movements = const [],
    this.users,
    this.addedMovement,
    this.removedMovement,
    this.isCycle = true,
    this.cycle = 1,
    this.duration = 3,
    this.initDate,
    this.finishDate,
    this.addedBudgetID,
    this.isDailyDebt,
    this.icon = const FiicoIcon.empty(),
  });

  final CreateBudgetStatus status;
  final Movement? addedMovement;
  final Movement? removedMovement;
  final List<FiicoUser>? users;
  List<Movement> movements;
  final Currency? currencySelected;
  final bool? isCycle;
  final int? cycle;
  final int? duration;
  final Timestamp? initDate;
  final Timestamp? finishDate;
  final String? addedBudgetID;
  final FiicoIcon? icon;
  final bool? isDailyDebt;

  List<Movement> get entrys =>
      movements.where((e) => e.getType() == MovementType.ENTRY).toList();
  List<Movement> get debts =>
      movements.where((e) => e.getType() == MovementType.DEBT).toList();

  List<Movement> get dailyDebts =>
      movements.where((e) => e.getType() == MovementType.DAILY_DEBT).toList();

  bool get isCompleteAdded => addedBudgetID?.isNotEmpty ?? false;

  @override
  List<Object> get props => [status];

  CreateBudgetState copyWith({
    CreateBudgetStatus? status,
    Currency? currencySelected,
    bool? isCycle,
    Movement? addedMovement,
    Movement? removedMovement,
    List<FiicoUser>? users,
    int? cycle,
    int? duration,
    Timestamp? initDate,
    Timestamp? finishDate,
    String? addedBudgetID,
    FiicoIcon? icon,
    bool? isDailyDebt,
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
      isCycle: isCycle ?? this.isCycle,
      cycle: cycle ?? this.cycle,
      duration: duration ?? this.duration,
      initDate: initDate ?? this.initDate,
      finishDate: finishDate ?? this.finishDate,
      users: users ?? this.users,
      addedBudgetID: addedBudgetID ?? this.addedBudgetID,
      isDailyDebt: isDailyDebt ?? this.isDailyDebt,
      movements: newMovements,
      icon: icon ?? this.icon,
    );
  }
}
