// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/pages_names.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_page.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/debtDetail/view/widget/debt_detail_bottom_view.dart';
import 'package:control/modules/debtDetail/view/widget/debt_detail_markpayed_success_view.dart';
import 'package:control/modules/editMovement/view/edit_movement_page.dart';
import 'package:control/modules/entryDetail/bloc/entry_detail_bloc.dart';
import 'package:control/modules/entryDetail/repository/entry_detail_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'entry_detail_success_view.dart';

class EntryDetailPage extends StatelessWidget {
  const EntryDetailPage({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement? movement;
  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EntryDetailBloc(EntryDetailRepository())
        ..add(EntryDetailBudgetFetchRequest(budget: budget)),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.entryDetailPage,
        child: EntryDetailPageView(movement: movement, budget: budget),
      ),
    );
  }
}

class EntryDetailPageView extends StatelessWidget {
  EntryDetailPageView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  Movement? movement;
  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EntryDetailBloc, EntryDetailState>(
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
          final budget = context.read<EntryDetailBloc>().state.budget;
          if (budget != null) {
            FiicoRoute.send(context, BudgetDetailPage(budget: budget));
          }
        },
        textColor: FiicoColors.graySoft,
        actions: [_dotsButton(context)],
      ),
      body: EntryDetailSuccessView(
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

  void _validateStatusView(BuildContext context, EntryDetailState state) {
    switch (state.status) {
      case EntryDetailStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfDeleteMovement(BuildContext context, EntryDetailState state) {
    if (state.isDeletedMovement) {
      Navigator.of(context).pop();
    }
  }

  void _validateIfModifyMovement(BuildContext context, EntryDetailState state) {
    if (state.isPayed) {
      movement = state.updatedMovement;
      MovementDetailMarkPayedSuccessBottomView.show(context);
    }

    if (state.isModify) {
      movement = state.updatedMovement;
    }
  }

  void _selectedOption(
      BuildContext context, DebtDetailBottomOption option) async {
    switch (option) {
      case DebtDetailBottomOption.delete_movement:
        deleteMovementAction(context);
        break;
      case DebtDetailBottomOption.modify_movement:
        _updateMovementAction(context);
        break;
    }
  }

  void deleteMovementAction(BuildContext context) {
    context
        .read<EntryDetailBloc>()
        .add(EntryDetailRemovedMovement(removeMovement: movement));
  }

  void _updateMovementAction(BuildContext context) async {
    final newMovement = await FiicoRoute.send(
      context,
      EditMovementPage(budget: budget, movementToEdit: movement),
    );
    if (newMovement != null) {
      context
          .read<EntryDetailBloc>()
          .add(EntryDetailEditMovement(movement: newMovement));
    }
  }
}
