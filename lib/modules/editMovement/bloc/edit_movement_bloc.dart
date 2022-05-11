import 'package:bloc/bloc.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createMovement/repository/create_movement_repository.dart';
import 'package:equatable/equatable.dart';

part 'edit_movement_event.dart';
part 'edit_movement_state.dart';

class EditMovementBloc extends Bloc<EditMovementEvent, EditMovementState> {
  EditMovementBloc(this.repository) : super(const EditMovementState()) {
    on<EditMovementAddedRequest>(_mapAddedMovementToState);
    on<EditMovementToEditRequest>(_mapEditMovementInfoToState);
    on<EditMovementInfoRequest>(_mapInfoToState);
  }

  final CreateMovementRepository repository;

  void _mapAddedMovementToState(
    EditMovementAddedRequest event,
    Emitter<EditMovementState> emit,
  ) async {
    emit(state.copyWith(status: EditMovementStatus.loading));
    try {
      await repository.addNewMovement(event.newMovement, event.budget);
      emit(state.copyWith(
        status: EditMovementStatus.success,
        onAddedCompleted: true,
      ));
    } catch (_) {
      emit(state.copyWith(status: EditMovementStatus.failure));
    }
  }

  void _mapInfoToState(
    EditMovementInfoRequest event,
    Emitter<EditMovementState> emit,
  ) async {
    emit(state.copyWith(status: EditMovementStatus.loading));
    emit(state.copyWith(
      status: EditMovementStatus.success,
      description: event.description,
      markDays: event.markDays,
      name: event.name,
      value: event.value,
      tags: event.tags,
      icon: event.icon,
      alert: event.alert,
    ));
  }

  void _mapEditMovementInfoToState(
    EditMovementToEditRequest event,
    Emitter<EditMovementState> emit,
  ) async {
    emit(state.copyWith(status: EditMovementStatus.loading));
    emit(state.copyWith(
      status: EditMovementStatus.success,
      description: event.editMovement?.description,
      markDays: event.editMovement?.recurrencyAt,
      name: event.editMovement?.name,
      value: event.editMovement?.value,
      tags: event.editMovement?.tags,
      icon: event.editMovement?.icon,
      alert: event.editMovement?.alert,
    ));
  }
}
