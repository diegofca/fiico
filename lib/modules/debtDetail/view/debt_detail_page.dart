// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/pages_names.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_page.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/debtDetail/bloc/debt_detail_bloc.dart';
import 'package:control/modules/debtDetail/repository/debt_detail_repository.dart';
import 'package:control/modules/debtDetail/view/widget/debt_detail_bottom_view.dart';
import 'package:control/modules/debtDetail/view/widget/debt_detail_markpayed_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'debt_detail_success_view.dart';

class DebtDetailPage extends StatelessWidget {
  const DebtDetailPage({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement? movement;
  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DebtDetailBloc(
        DebtDetailRepository(),
      )..add(DebtDetailBudgetFetchRequest(budget: budget)),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.debtDetailPage,
        child: DebtDetailPageView(movement: movement, budget: budget),
      ),
    );
  }
}

class DebtDetailPageView extends StatelessWidget {
  DebtDetailPageView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  Movement? movement;
  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebtDetailBloc, DebtDetailState>(
      builder: (context, state) {
        return _bodyContainer(context);
      },
      listener: (context, state) {
        _validateStatusView(context, state);
        _validateIfDeleteMovement(context, state);
        _validateIfModifyMovement(context, state);
      },
    );
  }

  Widget _bodyContainer(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: movement?.budgetName,
        textClicked: () {
          final budget = context.read<DebtDetailBloc>().state.budget;
          if (budget != null) {
            FiicoRoute.send(context, BudgetDetailPage(budget: budget));
          }
        },
        textColor: FiicoColors.graySoft,
        actions: [_dotsButton(context)],
      ),
      body: DebtDetailSuccessView(
        movement: movement,
        budget: budget,
      ),
    );
  }

  Widget _dotsButton(BuildContext context) {
    return Visibility(
      visible: budget?.isOwner ?? false,
      child: Padding(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.sixteen,
        ),
        child: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () {
            DebtDetailBottomView().show(
              context,
              onOptionSelected: (option) => _selectedOption(context, option),
            );
          },
          icon: const Icon(
            MdiIcons.dotsHorizontal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _validateStatusView(BuildContext context, DebtDetailState state) {
    switch (state.status) {
      case DebtDetailStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfDeleteMovement(BuildContext context, DebtDetailState state) {
    if (state.isDeletedMovement) {
      Navigator.of(context).pop();
    }
  }

  void _validateIfModifyMovement(BuildContext context, DebtDetailState state) {
    if (state.isPayed) {
      movement = state.updatedMovement;
      MovementDetailMarkPayedSuccessBottomView.show(context);
    }

    if (state.isModify) {
      movement = state.updatedMovement;
    }
  }

  void _selectedOption(BuildContext context, DebtDetailBottomOption option) {
    switch (option) {
      case DebtDetailBottomOption.delete_movement:
        context
            .read<DebtDetailBloc>()
            .add(DebtDetailRemovedMovement(removeMovement: movement));
        break;
      case DebtDetailBottomOption.modify_movement:
        break;
    }
  }
}
