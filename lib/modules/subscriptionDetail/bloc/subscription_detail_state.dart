part of 'subscription_detail_bloc.dart';

enum SubscriptionDetailStatus { init, loading }

class SubscriptionDetailState extends Equatable {
  const SubscriptionDetailState({
    this.status = SubscriptionDetailStatus.init,
    this.plan,
  });

  final SubscriptionDetailStatus status;
  final Plan? plan;

  bool get isUpdatePlan => plan != null;

  @override
  List<Object?> get props => [status, isUpdatePlan];

  SubscriptionDetailState copyWith({
    SubscriptionDetailStatus? status,
    Plan? plan,
  }) {
    return SubscriptionDetailState(
      status: status ?? this.status,
      plan: plan,
    );
  }
}
