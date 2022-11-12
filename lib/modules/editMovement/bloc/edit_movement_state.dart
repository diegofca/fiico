part of 'edit_movement_bloc.dart';

enum EditMovementStatus { success, loading, failure }

class EditMovementState extends Equatable {
  const EditMovementState({
    this.status = EditMovementStatus.loading,
    this.onAddedCompleted,
    this.recurrencyDates,
    this.isVariableValue,
    this.name,
    this.description,
    this.tags,
    this.value,
    this.markDays,
    this.icon,
    this.alert,
  });

  final EditMovementStatus status;
  final bool? onAddedCompleted;
  final String? name;
  final String? description;
  final List<String>? tags;
  final num? value;
  final List<int>? markDays;
  final FiicoIcon? icon;
  final FiicoAlert? alert;
  final List<Timestamp>? recurrencyDates;
  final bool? isVariableValue;

  bool get isAdded => onAddedCompleted ?? false;

  @override
  List<Object> get props => [status];

  EditMovementState copyWith({
    EditMovementStatus? status,
    bool? onAddedCompleted,
    String? name,
    String? description,
    String? typeDescription,
    List<String>? tags,
    num? value,
    List<int>? markDays,
    FiicoIcon? icon,
    FiicoAlert? alert,
    List<Timestamp>? recurrencyDates,
    bool? isVariableValue,
  }) {
    return EditMovementState(
      status: status ?? this.status,
      onAddedCompleted: onAddedCompleted ?? this.onAddedCompleted,
      recurrencyDates: recurrencyDates ?? this.recurrencyDates,
      isVariableValue: isVariableValue ?? this.isVariableValue,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      tags: tags ?? this.tags,
      markDays: markDays ?? this.markDays,
      alert: alert ?? this.alert,
      icon: icon ?? this.icon,
    );
  }
}
