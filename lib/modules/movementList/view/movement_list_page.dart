// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/helpers/pages_names.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/budgetDetail/repository/budget_detail_repository.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/createMovement/view/create_movement_page.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/view/default_movement_page.dart';
import 'package:control/modules/editMovement/view/edit_movement_page.dart';
import 'package:control/modules/home/view/widgets/home_create_movement_selector.dart';
import 'package:control/modules/movementList/bloc/bloc/movement_list_bloc.dart';
import 'package:control/modules/movementList/view/movement_list_success_view.dart';
import 'package:control/modules/movementList/view/movement_list_type_selector.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MovementsListPage extends StatelessWidget {
  const MovementsListPage({
    Key? key,
    required this.budget,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;
  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => MovementListBloc(
        BudgetDetailRepository(budget.id),
      )..add(MovementListFetchRequest(budget: budget)),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.budgetPage,
        child: MovementsListPageView(newBudget: budget),
      ),
    );
  }
}

class MovementsListPageView extends StatelessWidget {
  MovementsListPageView({
    Key? key,
    required this.newBudget,
  }) : super(key: key);

  Budget newBudget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovementListBloc, MovementListState>(
      builder: (context, state) {
        return _bodyContainer(state);
      },
      listener: (context, state) {
        _validateStatusView(context, state);
      },
    );
  }

  Widget _bodyContainer(MovementListState state) {
    return StreamBuilder<Budget>(
      stream: state.budget,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          newBudget = snapshot.requireData;
          return Scaffold(
            backgroundColor: FiicoColors.grayBackground,
            appBar: GenericAppBar(
              textColor: FiicoColors.black,
              actions: [
                _addMovementButton(context),
                _changeMovementsTypeButton(context)
              ],
              text: _getTitleText(context),
            ),
            body: MovementListSuccessView(
              dropDownValue: state.value,
              budget: newBudget,
            ),
          );
        }
        return const LoadingView();
      },
    );
  }

  Widget _addMovementButton(BuildContext context) {
    return Visibility(
      visible: newBudget.isReadAndWriteOnly,
      child: Padding(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
        ),
        child: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => _addMovementClickedAction(context),
          icon: const Icon(
            MdiIcons.plusCircleOutline,
            color: FiicoColors.grayDark,
          ),
        ),
      ),
    );
  }

  Widget _changeMovementsTypeButton(BuildContext context) {
    return Visibility(
      visible: newBudget.isReadAndWriteOnly,
      child: Padding(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.sixteen,
        ),
        child: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => _changeMovementTypeClickedAction(context),
          icon: const Icon(
            MdiIcons.arrowDownDropCircle,
            color: FiicoColors.grayDark,
          ),
        ),
      ),
    );
  }

  void _validateStatusView(BuildContext context, MovementListState state) {
    switch (state.status) {
      case MovementListStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _addMovementClickedAction(BuildContext context) {
    HomeCreateMovementBottomView().show(
      context,
      onOptionSelected: (option) => _selectedOption(context, option),
    );
  }

  void _changeMovementTypeClickedAction(BuildContext context) {
    MovementListTypeBottomView().show(
      context,
      onOptionSelected: (option) {
        var value = 4;
        switch (option) {
          case MovementListTypeOption.all:
            value = 8;
            break;
          case MovementListTypeOption.entry:
            value = 3;
            break;
          default:
        }
        context
            .read<MovementListBloc>()
            .add(MovementListSelectedTypeRequest(value: value));
      },
    );
  }

  void _selectedOption(
      BuildContext context, HomeCreateMovementBottomOption option) {
    final type = option == HomeCreateMovementBottomOption.add_debt
        ? MovementType.DEBT
        : MovementType.ENTRY;
    _showAlertDefualtMovementClickedAction(context, type);
  }

  void _showAlertDefualtMovementClickedAction(
      BuildContext context, MovementType type) async {
    DefaultMovementPage().show(
      context,
      budget: newBudget,
      list: MovementsList.getListBy(type: type),
      onMovementSelected: (movement) => _editDefaultMovement(context, movement),
      onNewItemSelected: () => _addedMovement(context, type),
    );
  }

  void _addedMovement(BuildContext context, MovementType type) async {
    final movement = await FiicoRoute.send(
      context,
      CreateMovementPage(
        budget: newBudget,
        addedinBudget: true,
        type: type,
      ),
    );
    if (movement is Movement) {
      context.read<MovementListBloc>().add(MovementListMovementAddedRequest(
          newMovement: movement, budget: newBudget));
    }
  }

  void _editDefaultMovement(BuildContext context, Movement movement) async {
    final newMovement = await FiicoRoute.send(
      context,
      EditMovementPage(
        budget: newBudget,
        addedinBudget: true,
        movementToEdit: movement,
      ),
    );
    if (newMovement is Movement) {
      context.read<MovementListBloc>().add(MovementListMovementAddedRequest(
          newMovement: newMovement, budget: newBudget));
    }
  }

  String _getTitleText(BuildContext context) {
    final value = context.read<MovementListBloc>().state.value;
    switch (value) {
      case 3:
        return '${FiicoLocale().incomesOf} ${newBudget.name}';
      case 4:
        return '${FiicoLocale().outcomesOf} ${newBudget.name}';
      default:
        return '${FiicoLocale().movementsOf} ${newBudget.name}';
    }
  }
}
