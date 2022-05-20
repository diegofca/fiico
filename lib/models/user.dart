// ignore_for_file: must_be_immutable

import 'package:control/models/budget.dart';
import 'package:control/models/payment_history.dart';
import 'package:control/models/plan.dart';
import 'package:control/network/firestore_path.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';

class FiicoUser extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? socialToken;
  final String? profileImage;
  final List<String>? deviceTokens;
  final bool? vip;
  final Plan? currentPlan;
  final List<Budget>? budgets;
  final List<PaymentPremium>? payments;
  final String? budgetPermission;
  final String? securityCode;
  final bool? authBiometric;
  final Currency? defaultCurrency;
  bool? showTutorial;

  FiicoUser({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.socialToken,
    this.profileImage,
    this.deviceTokens,
    this.vip,
    this.currentPlan,
    this.budgets,
    this.showTutorial = false,
    this.budgetPermission,
    this.securityCode,
    this.authBiometric,
    this.payments,
    this.defaultCurrency,
  });

  factory FiicoUser.fromJson(Map<String, dynamic>? json) {
    return FiicoUser(
      id: json?['id'],
      firstName: json?['firstName'],
      lastName: json?['lastName'],
      userName: json?['userName'],
      socialToken: json?['socialToken'],
      profileImage: json?['profileImage'],
      deviceTokens: List.castFrom(json?['deviceTokens']),
      currentPlan: Plan.fromJson(json?['currentPlan']),
      defaultCurrency: Currency.from(json: json?['defaultCurrency']),
      budgets: Budget.toList(json?['budgets']),
      payments: PaymentPremium.toList(json),
      showTutorial: json?['showTutorial'],
      budgetPermission: json?['budgetPermission'],
      authBiometric: json?['authBiometric'],
      securityCode: json?['securityCode'],
      email: json?['email'],
      vip: json?['vip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'firstName': firstName ?? '',
      'lastName': lastName ?? '',
      'userName': userName ?? '',
      'email': email ?? '',
      'socialToken': socialToken ?? '',
      'deviceTokens': deviceTokens ?? [],
      'currentPlan': currentPlan?.toJson(),
      'profileImage': profileImage ?? '',
      'showTutorial': showTutorial ?? false,
      'budgetPermission': budgetPermission ?? '',
      'authBiometric': authBiometric ?? false,
      'securityCode': securityCode ?? '',
      'defaultCurrency': defaultCurrency?.toJson(),
      'payments': payments?.map((e) => e.toJson()).toList() ?? [],
      'vip': vip ?? false,
    };
  }

  static List<FiicoUser> toList(Map<String, dynamic>? json) {
    List<FiicoUser> users = [];
    json?[Firestore.usersField]?.forEach((move) {
      users.add(FiicoUser.fromJson(move));
    });
    return users;
  }

  FiicoUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? socialToken,
    String? profileImage,
    List<String>? deviceTokens,
    bool? vip,
    Plan? currentPlan,
    List<Budget>? budgets,
    List<PaymentPremium>? payments,
    String? budgetPermission,
    String? securityCode,
    bool? authBiometric,
    Currency? defaultCurrency,
  }) {
    return FiicoUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      socialToken: socialToken ?? this.socialToken,
      profileImage: profileImage ?? this.profileImage,
      deviceTokens: deviceTokens ?? this.deviceTokens,
      vip: vip ?? this.vip,
      currentPlan: currentPlan ?? this.currentPlan,
      budgets: budgets ?? this.budgets,
      budgetPermission: budgetPermission ?? this.budgetPermission,
      securityCode: securityCode ?? this.securityCode,
      authBiometric: authBiometric ?? this.authBiometric,
      payments: payments ?? this.payments,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      showTutorial: showTutorial,
    );
  }

  @override
  List<Object?> get props => [
        id,
        vip,
        userName,
        socialToken,
        deviceTokens,
        currentPlan,
        profileImage,
        securityCode,
        authBiometric
      ];

  @override
  bool operator ==(other) {
    return other is FiicoUser && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  //Generic functions

  // que tipo de permiso tiene el usuario en el budget.
  int getPermission() {
    return budgetPermission == 'WRITE' ? 1 : 0;
  }

  bool isRadAndWriteOnly() {
    return budgetPermission == 'WRITE';
  }

  bool isPremium() {
    return currentPlan?.isPremium() ?? false;
  }

  bool isUnlimited() {
    return currentPlan?.isUnlimited() ?? false;
  }

  bool isActivePlan() {
    return currentPlan?.enable ?? false;
  }
}
