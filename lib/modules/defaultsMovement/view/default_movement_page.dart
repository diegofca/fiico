// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/view/widgets/default_movement_item_view.dart';
import 'package:flutter/material.dart';

class DefaultMovementPage {
  void show(
    BuildContext context, {
    required Function(Movement) onMovementSelected,
    required Budget budget,
    required Function onNewItemSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DefaultMovementPageView(
          onMovementSelected: onMovementSelected,
          onNewItemSelected: onNewItemSelected,
          budget: budget,
        );
      },
    );
  }
}

class DefaultMovementPageView extends StatelessWidget {
  DefaultMovementPageView({
    Key? key,
    required this.onMovementSelected,
    required this.budget,
    required this.onNewItemSelected,
  }) : super(key: key);

  Function(Movement) onMovementSelected;
  Function onNewItemSelected;

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          padding: EdgeInsets.only(
            left: FiicoPaddings.eight,
            right: FiicoPaddings.eight,
            top: FiicoPaddings.thirtyTwo,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(FiicoPaddings.twenyFour),
              topRight: Radius.circular(FiicoPaddings.twenyFour),
            ),
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                _title(),
                _movementListView(Movements.items, onMovementSelected),
                _createButtonView(context, onNewItemSelected),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.twenyFour,
      ),
      child: Text(
        "Usa movimientos pre-definidos",
        style: Style.title.copyWith(
          color: FiicoColors.black,
          fontSize: FiicoFontSize.md,
        ),
      ),
    );
  }

  Widget _movementListView(
      List<Movement> movements, Function(Movement) onMovementSelected) {
    return SizedBox(
      height: movements.length * 75,
      child: ListView.builder(
        itemCount: movements.length,
        itemBuilder: (context, index) {
          Movement movement = movements[index];
          return Container(
            margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
            child: DefaultMovementListItemView(
              movement: movement,
              onSelected: (movement) {
                Navigator.of(context).pop();
                onMovementSelected.call(movement);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _createButtonView(BuildContext context, Function onNewItemSelected) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.sixteen,
        horizontal: FiicoPaddings.fourtySix,
      ),
      child: FiicoButton.pink(
        title: 'Crear uno nuevo',
        ontap: () {
          Navigator.of(context).pop();
          onNewItemSelected.call();
        },
      ),
    );
  }
}
