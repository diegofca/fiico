import 'package:control/models/plan.dart';
import 'package:control/network/firestore_path.dart';

class PaymentPremium {
  final Plan plan;
  final String? paymentID;

  PaymentPremium({required this.plan, required this.paymentID});

  static List<PaymentPremium> toList(Map<String, dynamic>? json) {
    List<PaymentPremium> payments = [];
    json?[Firestore.paymentsHistory]?.forEach((move) {
      payments.add(PaymentPremium.fromJson(move));
    });
    return payments;
  }

  factory PaymentPremium.fromJson(Map<String, dynamic>? json) {
    return PaymentPremium(
      paymentID: json?['paymentID'],
      plan: Plan.fromJson(json?['plan']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'plan': plan.toJson(),
    };
  }
}
