part of 'alert_selector_bloc.dart';

abstract class AlertSelectorEvent extends Equatable {
  const AlertSelectorEvent();
}

class AlertSelectorInfoRequest extends AlertSelectorEvent {
  const AlertSelectorInfoRequest({
    this.isIntensive,
    this.day,
    this.dates,
  });

  final bool? isIntensive;
  final int? day;
  final List<DateTime>? dates;

  @override
  List<Object?> get props => [isIntensive, day, dates];
}
