part of 'premium_bloc.dart';

abstract class PremiumEvent extends Equatable {
  const PremiumEvent();
}

class PremiumCompletePurchase extends PremiumEvent {
  const PremiumCompletePurchase({required this.paymentPremium});

  final PaymentPremium paymentPremium;

  @override
  List<Object?> get props => [paymentPremium];
}
