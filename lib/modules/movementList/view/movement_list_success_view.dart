import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/movementList/view/itemList/movement_list_item_view.dart';
import 'package:flutter/material.dart';

class MovementListSuccessView extends StatelessWidget {
  const MovementListSuccessView({
    Key? key,
    required this.budget,
  }) : super(key: key);

  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _budgetsList(),
    );
  }

  Widget _budgetsList() {
    final movements = budget?.getMovementsBy(7) ?? [];
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: const [
          BoxShadow(
            color: FiicoColors.grayLite,
            blurRadius: 5,
            spreadRadius: 20,
          )
        ],
      ),
      child: ListView.builder(
        itemCount: movements.length,
        itemBuilder: (context, index) {
          final movement = movements[index];
          return MovementListItemView(movement: movement, budget: budget);
        },
      ),
    );
  }
}
