part of 'default_movement_bloc.dart';

abstract class DefaultMovementEvent extends Equatable {
  const DefaultMovementEvent();
}

class DefaultMovementSelectSegment extends DefaultMovementEvent {
  const DefaultMovementSelectSegment({this.index});

  final int? index;

  @override
  List<Object?> get props => [index];
}
