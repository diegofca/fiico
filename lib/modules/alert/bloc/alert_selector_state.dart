part of 'alert_selector_bloc.dart';

enum AlertSelectorStatus { waiting, addedLoading }

class AlertSelectorState extends Equatable {
  const AlertSelectorState({
    this.status = AlertSelectorStatus.waiting,
    this.isIntensive,
    this.dates,
    this.day,
  });

  final AlertSelectorStatus status;
  final bool? isIntensive;
  final int? day;
  final List<DateTime>? dates;

  // FiicoAlert get alert => onAddedCompleted ?? false;

  @override
  List<Object> get props => [status];

  AlertSelectorState copyWith({
    AlertSelectorStatus? status,
    bool? isIntensive,
    List<DateTime>? dates,
    int? day,
  }) {
    return AlertSelectorState(
      status: status ?? this.status,
      isIntensive: isIntensive ?? this.isIntensive,
      dates: dates ?? this.dates,
      day: day ?? this.day,
    );
  }
}
