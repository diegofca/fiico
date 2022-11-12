// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/bloc/default_movement_bloc.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/view/default_movement_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultMovementPage {
  void show(
    BuildContext context, {
    required Function(Movement) onMovementSelected,
    required Budget budget,
    required Function onNewItemSelected,
    required MovementsList list,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => DefaultMovementBloc(),
          child: DefaultMovementPageView(
            onMovementSelected: onMovementSelected,
            onNewItemSelected: onNewItemSelected,
            budget: budget,
            list: list,
          ),
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
    required this.list,
  }) : super(key: key);

  Function(Movement) onMovementSelected;
  Function onNewItemSelected;

  final Budget budget;
  final MovementsList list;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultMovementBloc, DefaultMovementState>(
      builder: (context, state) {
        switch (state.status) {
          case DefaultMovementStatus.success:
            return _bodyContainer();
          case DefaultMovementStatus.waiting:
            return const LoadingView();
        }
      },
    );
  }

  Widget _bodyContainer() {
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
              alignment: WrapAlignment.center,
              children: [
                _title(),
                DefaultMovementSuccessView(
                  movementList: list,
                  onMovementSelected: onMovementSelected,
                ),
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
      ),
      child: Text(
        list.name,
        style: Style.title.copyWith(
          color: FiicoColors.black,
          fontSize: FiicoFontSize.md,
        ),
      ),
    );
  }

  Widget _createButtonView(BuildContext context, Function onNewItemSelected) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.eight,
        horizontal: FiicoPaddings.sixteen,
      ),
      child: FiicoButton(
        title: FiicoLocale().createNewMovement,
        color: FiicoColors.white,
        borderColor: FiicoColors.purpleDark,
        textColor: FiicoColors.purpleDark,
        onTap: () {
          Navigator.of(context).pop();
          onNewItemSelected.call();
        },
      ),
    );
  }
}
