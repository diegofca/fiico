// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createMovement/repository/create_movement_repository.dart';
import 'package:control/modules/editMovement/bloc/edit_movement_bloc.dart';
import 'package:control/modules/editMovement/view/edit_movement_sucess_view.dart';
import 'package:control/modules/premium/view/premium_page.dart';
import 'package:control/modules/premiumUpdate/view/premium_update_page.dart';
import 'package:control/modules/subscriptionDetail/view/subscription_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditMovementPage extends StatelessWidget {
  EditMovementPage({
    Key? key,
    required this.budget,
    required this.movementToEdit,
    this.addedinBudget = false,
  }) : super(key: key);

  final Budget? budget;
  final bool addedinBudget;
  Movement? movementToEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: budget?.name ?? '',
        textColor: FiicoColors.black,
        actions: [_infoButton(context)],
      ),
      body: BlocProvider(
        create: (context) => EditMovementBloc(
          CreateMovementRepository(budget?.id ?? ''),
        )..add(EditMovementToEditRequest(
            editMovement: movementToEdit,
            budget: budget,
          )),
        child: EditMovementPageView(
          addedinBudget: addedinBudget,
          movement: movementToEdit,
          updateMovement: (newMovement) {
            movementToEdit = newMovement;
          },
          budget: budget,
        ),
      ),
    );
  }

  Widget _infoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () => _editMovement(context),
        icon: const Icon(
          MdiIcons.checkAll,
          color: FiicoColors.greenNeutral,
        ),
      ),
    );
  }

  void _editMovement(BuildContext context) async {
    final type = movementToEdit?.getType();
    final isCreateAvailable =
        await FiicoRemoteConfig.isCanCreateMovement(type, budget);
    final isCompleteByCreate = movementToEdit?.isCompleteByCreate() ?? false;

    if (isCompleteByCreate && isCreateAvailable) {
      Navigator.of(context).pop(movementToEdit);
    } else if (!isCreateAvailable) {
      _showErrorUserNotPremium(context);
    } else {
      FiicoAlertDialog.showWarnning(
        context,
        title: FiicoLocale().emptyFields,
        message: FiicoLocale().completeMissingFieldsAddMovement,
      );
    }
  }

  void _showErrorUserNotPremium(BuildContext context) async {
    final user = await Preferences.get.getUser();
    PremiumUpdatePage().show(context, onUpdateIntent: () {
      FiicoRoute.send(
        context,
        PremiumPage(
          user: user,
          showPlan: (plan) {
            final newUser = user?.copyWith(currentPlan: plan);
            FiicoRoute.send(context, SubscriptionDetailPage(user: newUser));
          },
        ),
      );
    });
  }
}

class EditMovementPageView extends StatelessWidget {
  const EditMovementPageView({
    Key? key,
    required this.budget,
    required this.movement,
    required this.updateMovement,
    required this.addedinBudget,
  }) : super(key: key);

  final Budget? budget;
  final Movement? movement;
  final Function(Movement?) updateMovement;
  final bool addedinBudget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditMovementBloc, EditMovementState>(
      builder: (context, state) {
        switch (state.status) {
          case EditMovementStatus.loading:
            return const LoadingView();
          default:
            return EditMovementSuccessView(
              movement: getMovementToBloc(state),
              budget: budget,
            );
        }
      },
      listener: (context, state) {
        _validateStatusView(context, state);
        _validateIfCompleteMovement(context, state);
      },
    );
  }

  void _validateStatusView(BuildContext context, EditMovementState state) {
    switch (state.status) {
      case EditMovementStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfCompleteMovement(
      BuildContext context, EditMovementState state) {
    if (state.isAdded) {
      Navigator.of(context).pop(getMovementToBloc(state));
    }
  }

  Movement getMovementToBloc(EditMovementState state) {
    final type = movement?.getType() == MovementType.ENTRY ? 'ENTRY' : 'DEBT';
    final typeDescription = movement?.getType() == MovementType.ENTRY
        ? FiicoLocale().income
        : FiicoLocale().outcome;

    final newMovement = Movement(
      id: movement?.id,
      name: state.name,
      value: state.value,
      icon: state.icon ?? const FiicoIcon.empty(),
      alert: state.alert ?? FiicoAlert.empty(),
      description: state.description,
      createdAt: Timestamp.now(),
      recurrencyAt: state.markDays,
      recurrencyDates: state.recurrencyDates,
      isVariableValue: state.isVariableValue,
      typeDescription: typeDescription,
      isAddedWithBudget: addedinBudget,
      paymentStatus: movement?.paymentStatus,
      markHistory: movement?.markHistory ?? [],
      currency: budget?.currency,
      budgetName: budget?.name,
      tags: state.tags ?? [],
      type: type,
    );
    updateMovement(newMovement);
    return newMovement;
  }
}
