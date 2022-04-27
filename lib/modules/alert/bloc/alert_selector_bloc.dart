import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alert_selector_event.dart';
part 'alert_selector_state.dart';

class AlertSelectorBloc extends Bloc<AlertSelectorEvent, AlertSelectorState> {
  AlertSelectorBloc() : super(const AlertSelectorState()) {
    on<AlertSelectorInfoRequest>(_mapAddedInfoToState);
  }

  void _mapAddedInfoToState(
    AlertSelectorInfoRequest event,
    Emitter<AlertSelectorState> emit,
  ) async {
    emit(state.copyWith(status: AlertSelectorStatus.waiting));
    emit(state.copyWith(
      status: AlertSelectorStatus.addedLoading,
      isIntensive: event.isIntensive,
      dates: event.dates,
      day: event.day,
    ));
  }
}
