// ignore_for_file: must_be_immutable

part of 'default_movement_bloc.dart';

enum DefaultMovementStatus { success, waiting }

class DefaultMovementState extends Equatable {
  const DefaultMovementState({
    this.status = DefaultMovementStatus.success,
    this.index,
  });

  final DefaultMovementStatus status;
  final int? index;

  @override
  List<Object> get props => [status];

  DefaultMovementState copyWith({
    DefaultMovementStatus? status,
    int? index = 0,
  }) {
    return DefaultMovementState(
      status: status ?? this.status,
      index: index ?? this.index,
    );
  }
}
