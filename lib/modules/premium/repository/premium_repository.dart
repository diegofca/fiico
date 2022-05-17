import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/payment_history.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class PremiumRepositoryAbs {
  Future<void> purchasePlanCompleted(
      FiicoUser? user, PaymentPremium paymentPremium);
}

class PremiumRepository extends PremiumRepositoryAbs {
  List<String> benefics = [
    FiicoLocale().createMoreThanOneBudget,
    FiicoLocale().createMoreExpenses,
    FiicoLocale().createMoreIncomes,
    FiicoLocale().shareYourQuotesWithFriends,
    FiicoLocale().financialSupportThatWillHelp,
    FiicoLocale().moreThanTwoDifferentLanguages,
    FiicoLocale().newBenefitsWithoutHavingToPayMore,
  ];
  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  //Generic ----------------------------------------------------------
  @override
  Future<void> purchasePlanCompleted(
    FiicoUser? user,
    PaymentPremium paymentPremium,
  ) {
    final updateUser = user?.copyWith(
      currentPlan: paymentPremium.plan.copyWith(
        paymentID: paymentPremium.paymentID,
      ),
      payments: user.payments?..add(paymentPremium),
    );
    return usersollections.doc(user?.id).update(updateUser?.toJson() ?? {});
  }
}
