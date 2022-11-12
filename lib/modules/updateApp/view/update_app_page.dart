// ignore_for_file: must_be_immutable

import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/modules/defaultsMovement/bloc/default_movement_bloc.dart';
import 'package:control/modules/updateApp/view/update_app_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAppPage {
  void show(
    BuildContext context, {
    required Function onCancelAction,
    required Function onUpdateAction,
    required bool forceUpdate,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: !forceUpdate,
      isDismissible: !forceUpdate,
      enableDrag: !forceUpdate,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => DefaultMovementBloc(),
          child: UpdateAppPageView(
            onCancelAction: onCancelAction,
            onUpdateAction: onUpdateAction,
            forceUpdate: forceUpdate,
          ),
        );
      },
    );
  }
}

class UpdateAppPageView extends StatelessWidget {
  const UpdateAppPageView({
    Key? key,
    required this.onUpdateAction,
    required this.onCancelAction,
    required this.forceUpdate,
  }) : super(key: key);

  final Function onCancelAction;
  final Function onUpdateAction;
  final bool forceUpdate;

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
            child: UpdateAppSuccessView(
              onCancelAction: onCancelAction,
              onUpdateAction: onUpdateAction,
              forceUpdate: forceUpdate,
            ),
          ),
        );
      },
    );
  }
}
