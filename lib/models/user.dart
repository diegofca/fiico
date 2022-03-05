import 'package:control/models/budget.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
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

  User({
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

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
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

  Map<String, String?> toJson() {
    return {
      'id': id.toString(),
      // 'firstName': name ?? "",
      // 'lastName': reason ?? "other",
      // 'userName': "${initDate?.getDateString("yyyy-MM-dd hh:mm:ss")}",
      // 'email': "${endDate()?.getDateString("yyyy-MM-dd hh:mm:ss")}",
      // 'socialToken': pricePerMember.toString(),
      // 'deviceTokens': randomOrder ?? false ? 1.toString() : 2.toString(),
      // 'vip': isDeduct ?? false ? 1.toString() : 2.toString(),
      // 'currentPlan': inviteUsers.length.toString(),
      // 'budgets': 3.toString(),
    };
  }

  @override
  List<Object?> get props => [id];
}
