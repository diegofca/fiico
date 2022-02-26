part of 'alert_selector_bloc.dart';

enum AlertSelectorStatus { waiting, addedLoading }

class AlertSelectorState extends Equatable {
  const AlertSelectorState({
    this.status = AlertSelectorStatus.waiting,
    this.isIntensive,
    this.date,
  });

  final AlertSelectorStatus status;
  final bool? isIntensive;
  final DateTime? date;

  // FiicoAlert get alert => onAddedCompleted ?? false;

  @override
  List<Object> get props => [status];

  AlertSelectorState copyWith({
    AlertSelectorStatus? status,
    bool? isIntensive,
    DateTime? date,
  }) {
    return AlertSelectorState(
      status: status ?? this.status,
      isIntensive: isIntensive ?? this.isIntensive,
      date: date ?? this.date,
    );
  }
}
