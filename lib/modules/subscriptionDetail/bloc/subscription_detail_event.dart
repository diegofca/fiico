part of 'subscription_detail_bloc.dart';

abstract class SubscriptionDetailEvent extends Equatable {
  const SubscriptionDetailEvent();
}

class UpdateSubscriptionDetail extends SubscriptionDetailEvent {
  const UpdateSubscriptionDetail({required this.newPlan});

  final Plan? newPlan;

  @override
  List<Object?> get props => [newPlan];
}
