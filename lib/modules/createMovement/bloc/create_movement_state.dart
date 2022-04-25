part of 'create_movement_bloc.dart';

enum CreateMovementStatus { success, loading, failure }

class CreateMovementState extends Equatable {
  const CreateMovementState({
    this.status = CreateMovementStatus.success,
    this.onAddedCompleted,
    this.name,
    this.description,
    this.tags,
    this.value,
    this.markDays,
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
  final List<int>? markDays;
  final Recurrency? recurrency;
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
    List<int>? markDays,
    Recurrency? recurrency,
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
      markDays: markDays ?? this.markDays,
      alert: alert ?? this.alert,
      icon: icon ?? this.icon,
      recurrency: recurrency ?? this.recurrency,
    );
  }
}
