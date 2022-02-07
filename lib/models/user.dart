class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? socialToken;
  final List<String>? deviceTokens;
  final bool? vip;
  final String? currentPlan;
  final List<int>? budgets;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.socialToken,
    this.deviceTokens,
    this.vip,
    this.currentPlan,
    this.budgets,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id: json?['id'],
      firstName: json?['firstName'],
      lastName: json?['firstName'],
      userName: json?['firstName'],
      socialToken: json?['firstName'],
      deviceTokens: json?['firstName'],
      currentPlan: json?['firstName'],
      budgets: json?['firstName'],
      email: json?['firstName'],
      vip: json?['firstName'],
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
}
