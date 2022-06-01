part of 'alert_selector_bloc.dart';

abstract class AlertSelectorEvent extends Equatable {
  const AlertSelectorEvent();
}

class AlertSelectorInfoRequest extends AlertSelectorEvent {
  const AlertSelectorInfoRequest({
    this.isIntensive,
    this.days,
    this.dates,
  });

  final bool? isIntensive;
  final List<int>? days;
  final List<DateTime>? dates;

  @override
  List<Object?> get props => [isIntensive, days, dates];
}
