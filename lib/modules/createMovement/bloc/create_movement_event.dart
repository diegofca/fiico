part of 'create_movement_bloc.dart';

abstract class CreateMovementEvent extends Equatable {
  const CreateMovementEvent();
}

class CreateMovementAddedRequest extends CreateMovementEvent {
  const CreateMovementAddedRequest({required this.newMovement});

  final Movement newMovement;

  @override
  List<Object?> get props => [newMovement];
}

class CreateMovementInfoRequest extends CreateMovementEvent {
  const CreateMovementInfoRequest({
    this.name,
    this.description,
    this.tags,
    this.value,
    this.date,
    this.recurrency,
  });

  final String? name;
  final String? description;
  final List<String>? tags;
  final num? value;
  final DateTime? date;
  final String? recurrency;

  @override
  List<Object?> get props => [name, description, tags, value, date, recurrency];
}
