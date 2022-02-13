import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createMovement/bloc/create_movement_bloc.dart';
import 'package:control/modules/createMovement/repository/create_movement_repository.dart';
import 'package:control/modules/createMovement/view/create_movement_success_view.dart';
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

  final Budget budget;
  final MovementType type;
  final bool addedinBudget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: budget.name,
        textColor: FiicoColors.black,
        actions: [_dotsButton()],
      ),
      body: BlocProvider(
        create: (context) => CreateMovementBloc(
          CreateMovementRepository(budget.id),
        ),
        child: CreateMovementPageView(
          currencyCode: budget.currency,
          budgetName: budget.name,
          addedinBudget: addedinBudget,
          type: type,
        ),
      ),
    );
  }

  Widget _dotsButton() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          print("dost button");
        },
        icon: const Icon(
          MdiIcons.dotsHorizontal,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CreateMovementPageView extends StatelessWidget {
  const CreateMovementPageView({
    Key? key,
    required this.budgetName,
    required this.type,
    required this.currencyCode,
    required this.addedinBudget,
  }) : super(key: key);

  final String? budgetName;
  final MovementType type;
  final String? currencyCode;
  final bool addedinBudget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateMovementBloc, CreateMovementState>(
      builder: (context, state) {
        switch (state.status) {
          case CreateMovementStatus.success:
          case CreateMovementStatus.waiting:
            return CreateMovementSuccessView(
              movement: getMovementToBloc(state),
            );
          case CreateMovementStatus.addedLoading:
            return const LoadingView(
              backgroundColor: Colors.red,
            );
          case CreateMovementStatus.failed:
            return Container(
              color: Colors.black,
            );
        }
      },
      listener: (context, state) {
        if (state.isAdded) {
          Navigator.of(context).pop(getMovementToBloc(state));
        }
      },
    );
  }

  Movement getMovementToBloc(CreateMovementState state) {
    final type = this.type == MovementType.ENTRY ? 'ENTRY' : 'DEBT';
    final typeDescription =
        this.type == MovementType.ENTRY ? 'Income' : 'Outcome';
    final createdAt = Timestamp.fromDate(state.date ?? DateTime.now());

    return Movement(
      id: const Uuid().v1(),
      name: state.name,
      value: state.value,
      createdAt: createdAt,
      description: state.description,
      typeDescription: typeDescription,
      recurrency: state.recurrency,
      isAddedWithBudget: addedinBudget,
      image: 'image',
      currency: currencyCode,
      budgetName: budgetName,
      tags: state.tags ?? [],
      type: type,
    );
  }
}
