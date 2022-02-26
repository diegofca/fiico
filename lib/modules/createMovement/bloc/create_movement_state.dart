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
    this.icon,
    this.alert,
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
  final FiicoIcon? icon;
  final FiicoAlert? alert;

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
    FiicoIcon? icon,
    FiicoAlert? alert,
  }) {
    return CreateMovementState(
      status: status ?? this.status,
      onAddedCompleted: onAddedCompleted ?? this.onAddedCompleted,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      tags: tags ?? this.tags,
      date: date ?? this.date,
      alert: alert ?? this.alert,
      icon: icon ?? this.icon,
      recurrency: recurrency ?? this.recurrency,
    );
  }
}
