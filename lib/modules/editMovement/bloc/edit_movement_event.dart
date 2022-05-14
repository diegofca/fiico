part of 'edit_movement_bloc.dart';

abstract class EditMovementEvent extends Equatable {
  const EditMovementEvent();
}

class EditMovementAddedRequest extends EditMovementEvent {
  const EditMovementAddedRequest({
    required this.newMovement,
    required this.budget,
  });

  final Movement newMovement;
  final Budget? budget;

  @override
  List<Object?> get props => [newMovement, budget];
}

class EditMovementInfoRequest extends EditMovementEvent {
  const EditMovementInfoRequest({
    this.name,
    this.description,
    this.tags,
    this.value,
    this.markDays,
    this.icon,
    this.alert,
    this.recurrencyDates,
  });

  final String? name;
  final String? description;
  final List<String>? tags;
  final num? value;
  final List<int>? markDays;
  final FiicoIcon? icon;
  final FiicoAlert? alert;
  final List<Timestamp>? recurrencyDates;

  @override
  List<Object?> get props =>
      [name, description, tags, value, markDays, icon, alert, recurrencyDates];
}

class EditMovementToEditRequest extends EditMovementEvent {
  const EditMovementToEditRequest({
    required this.editMovement,
    required this.budget,
  });

  final Movement? editMovement;
  final Budget? budget;

  @override
  List<Object?> get props => [editMovement, budget];
}
