import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'default_movement_state.dart';
part 'default_movement_event.dart';

class DefaultMovementBloc
    extends Bloc<DefaultMovementEvent, DefaultMovementState> {
  DefaultMovementBloc() : super(const DefaultMovementState()) {
    on<DefaultMovementSelectSegment>(_mapSelectSegmentToState);
  }

  void _mapSelectSegmentToState(
    DefaultMovementSelectSegment event,
    Emitter<DefaultMovementState> emit,
  ) async {
    emit(state.copyWith(status: DefaultMovementStatus.waiting));
    emit(state.copyWith(
      status: DefaultMovementStatus.success,
      index: event.index,
    ));
  }
}
