class ShareBudget {
  final String budgetId;
  final String ownerId;

  ShareBudget({
    required this.budgetId,
    required this.ownerId,
  });
  factory ShareBudget.fromJson(Map<String, dynamic>? json) {
    return ShareBudget(
      budgetId: json?['budgetID'],
      ownerId: json?['ownerID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetID': budgetId,
      'ownerID': ownerId,
    };
  }
}
