part of 'create_movement_bloc.dart';

enum CreateMovementStatus { waiting, addedLoading, success, failed }

class CreateMovementState extends Equatable {
  const CreateMovementState({
    this.status = CreateMovementStatus.waiting,
    this.onAddedCompleted,
    this.name,
    this.description,
    this.tags,
    this.value,
    this.date,
    this.recurrency,
  });

  final CreateMovementStatus status;
  final bool? onAddedCompleted;
  final String? name;
  final String? description;
  final List<String>? tags;
  final num? value;
  final DateTime? date;
  final String? recurrency;

  bool get isAdded => onAddedCompleted ?? false;

  @override
  List<Object> get props => [status];

  CreateMovementState copyWith({
    CreateMovementStatus? status,
    bool? onAddedCompleted,
    String? name,
    String? description,
    String? typeDescription,
    List<String>? tags,
    num? value,
    DateTime? date,
    String? recurrency,
  }) {
    return CreateMovementState(
      status: status ?? this.status,
      onAddedCompleted: onAddedCompleted ?? this.onAddedCompleted,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      tags: tags ?? this.tags,
      date: date ?? this.date,
      recurrency: recurrency ?? this.recurrency,
    );
  }
}
