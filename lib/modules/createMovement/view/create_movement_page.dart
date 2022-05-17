import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createMovement/bloc/create_movement_bloc.dart';
import 'package:control/modules/createMovement/repository/create_movement_repository.dart';
import 'package:control/modules/createMovement/view/create_movement_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateMovementPage extends StatelessWidget {
  const CreateMovementPage({
    Key? key,
    required this.budget,
    required this.type,
    this.addedinBudget = false,
  }) : super(key: key);

  final Budget? budget;
  final MovementType type;
  final bool addedinBudget;

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
        create: (context) => CreateMovementBloc(
          CreateMovementRepository(budget?.id ?? ''),
        ),
        child: CreateMovementPageView(
          currencyCode: budget?.currency,
          addedinBudget: addedinBudget,
          budget: budget,
          type: type,
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
        onPressed: () {
          FiicoAlertDialog.showSuccess(context,
              title: FiicoLocale().movement,
              message:
                  'Los movimientos son acciones que modifican tu saldo total, en este puede estar un gasto, ahorro o ingreso.');
        },
        icon: const Icon(
          MdiIcons.informationOutline,
          color: FiicoColors.grayDark,
        ),
      ),
    );
  }
}

class CreateMovementPageView extends StatelessWidget {
  const CreateMovementPageView({
    Key? key,
    required this.budget,
    required this.type,
    required this.currencyCode,
    required this.addedinBudget,
  }) : super(key: key);

  final Budget? budget;
  final MovementType type;
  final String? currencyCode;
  final bool addedinBudget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateMovementBloc, CreateMovementState>(
      builder: (context, state) {
        return CreateMovementSuccessView(
          movement: getMovementToBloc(state),
          budget: budget,
        );
      },
      listener: (context, state) {
        _validateStatusView(context, state);
        _validateIfCompleteMovement(context, state);
      },
    );
  }

  void _validateStatusView(BuildContext context, CreateMovementState state) {
    switch (state.status) {
      case CreateMovementStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfCompleteMovement(
      BuildContext context, CreateMovementState state) {
    if (state.isAdded) {
      Navigator.of(context).pop(getMovementToBloc(state));
    }
  }

  Movement getMovementToBloc(CreateMovementState state) {
    final type = this.type == MovementType.ENTRY ? 'ENTRY' : 'DEBT';
    final typeDescription =
        this.type == MovementType.ENTRY ? 'Income' : 'Outcome';
    final recurrencyDay = state.markDays;
    const paymentStatus = 'Pending';

    return Movement(
      id: const Uuid().v1(),
      name: state.name,
      value: state.value,
      icon: state.icon ?? const FiicoIcon.empty(),
      alert: state.alert ?? FiicoAlert.empty(),
      recurrencyDates: state.recurrencyDates ?? [],
      description: state.description,
      createdAt: Timestamp.now(),
      recurrencyAt: recurrencyDay,
      typeDescription: typeDescription,
      isAddedWithBudget: addedinBudget,
      paymentStatus: paymentStatus,
      currency: currencyCode,
      budgetName: budget?.name,
      tags: state.tags ?? [],
      type: type,
    );
  }
}
