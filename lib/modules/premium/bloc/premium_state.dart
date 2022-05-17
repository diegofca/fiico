part of 'premium_bloc.dart';

enum PremiumStatus { init, loading }

class PremiumState extends Equatable {
  const PremiumState({
    this.status = PremiumStatus.init,
    this.paymentPremium,
  });

  final PremiumStatus status;
  final PaymentPremium? paymentPremium;

  bool get isCompletePayment => paymentPremium != null;

  @override
  List<Object?> get props => [status, paymentPremium];

  PremiumState copyWith({
    PremiumStatus? status,
    PaymentPremium? paymentPremium,
  }) {
    return PremiumState(
      status: status ?? this.status,
      paymentPremium: paymentPremium,
    );
  }
}
