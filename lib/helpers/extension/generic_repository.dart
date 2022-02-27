import 'package:control/models/budget.dart';

abstract class BudgetGenericRepositoryAbs {
  Future<Budget> getBudget(String budgetID);
  Future<void> updateBudget(Budget budget);
}
