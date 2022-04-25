import 'package:bloc/bloc.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/recurrency.dart';
import 'package:control/modules/createMovement/repository/create_movement_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_movement_event.dart';
part 'create_movement_state.dart';

class CreateMovementBloc
    extends Bloc<CreateMovementEvent, CreateMovementState> {
  CreateMovementBloc(this.repository) : super(const CreateMovementState()) {
    on<CreateMovementAddedRequest>(_mapAddedMovementToState);
    on<CreateMovementInfoRequest>(_mapAddedNameToState);
  }

  final CreateMovementRepository repository;

  void _mapAddedMovementToState(
    CreateMovementAddedRequest event,
    Emitter<CreateMovementState> emit,
  ) async {
    emit(state.copyWith(status: CreateMovementStatus.loading));
    try {
      await repository.addNewMovement(event.newMovement, event.budget);
      emit(state.copyWith(
        status: CreateMovementStatus.success,
        onAddedCompleted: true,
      ));
    } catch (_) {
      emit(state.copyWith(status: CreateMovementStatus.failure));
    }
  }

  void _mapAddedNameToState(
    CreateMovementInfoRequest event,
    Emitter<CreateMovementState> emit,
  ) async {
    emit(state.copyWith(status: CreateMovementStatus.loading));
    emit(state.copyWith(
      status: CreateMovementStatus.success,
      description: event.description,
      recurrency: event.recurrency,
      markDays: event.markDays,
      name: event.name,
      value: event.value,
      tags: event.tags,
      icon: event.icon,
      alert: event.alert,
    ));
  }
}
