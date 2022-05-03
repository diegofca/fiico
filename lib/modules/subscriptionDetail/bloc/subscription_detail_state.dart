part of 'subscription_detail_bloc.dart';

abstract class SubscriptionDetailState extends Equatable {
  const SubscriptionDetailState();
  
  @override
  List<Object> get props => [];
}

class SubscriptionDetailInitial extends SubscriptionDetailState {}
