import 'package:control/models/budget.dart';
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

  const FiicoUser({
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
      'vip': vip ?? false,
    };
  }

  @override
  List<Object?> get props => [id];
}
