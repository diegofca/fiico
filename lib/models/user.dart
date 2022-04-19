// ignore_for_file: must_be_immutable

import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';
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
  final String? currentPlan;
  final List<Budget>? budgets;
  final String? budgetPermission;
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
      currentPlan: json?['currentPlan'],
      budgets: Budget.toList(json?['budgets']),
      showTutorial: json?['showTutorial'],
      budgetPermission: json?['budgetPermission'],
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
      'currentPlan': currentPlan ?? '',
      'profileImage': profileImage ?? '',
      'showTutorial': showTutorial ?? false,
      'budgetPermission': budgetPermission ?? '',
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
    String? currentPlan,
    List<Budget>? budgets,
    String? budgetPermission,
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
    );
  }

  @override
  List<Object?> get props =>
      [id, socialToken, deviceTokens, currentPlan, profileImage, vip];

  //Generic functions
  int getPermission() {
    return budgetPermission == 'WRITE' ? 1 : 0;
  }

  bool isRadAndWriteOnly() {
    return budgetPermission == 'WRITE';
  }
}
