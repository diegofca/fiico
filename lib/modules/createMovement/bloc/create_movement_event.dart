part of 'create_movement_bloc.dart';

abstract class CreateMovementEvent extends Equatable {
  const CreateMovementEvent();
}

class CreateMovementAddedRequest extends CreateMovementEvent {
  const CreateMovementAddedRequest({
    required this.newMovement,
    required this.budget,
  });

  final Movement newMovement;
  final Budget? budget;

  @override
  List<Object?> get props => [newMovement, budget];
}

class CreateMovementInfoRequest extends CreateMovementEvent {
  const CreateMovementInfoRequest({
    this.name,
    this.description,
    this.tags,
    this.value,
    this.markDays,
    this.icon,
    this.alert,
  });

  final String? name;
  final String? description;
  final List<String>? tags;
  final num? value;
  final List<int>? markDays;
  final FiicoIcon? icon;
  final FiicoAlert? alert;

  @override
  List<Object?> get props =>
      [name, description, tags, value, markDays, icon, alert];
}
