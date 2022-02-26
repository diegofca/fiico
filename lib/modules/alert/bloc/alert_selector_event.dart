part of 'alert_selector_bloc.dart';

abstract class AlertSelectorEvent extends Equatable {
  const AlertSelectorEvent();
}

class AlertSelectorInfoRequest extends AlertSelectorEvent {
  const AlertSelectorInfoRequest({
    this.isIntensive,
    this.date,
  });

  final bool? isIntensive;
  final DateTime? date;
  // final FiicoAlert? alert;

  @override
  List<Object?> get props => [isIntensive, date];
}
