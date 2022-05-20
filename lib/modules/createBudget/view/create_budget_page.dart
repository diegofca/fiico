import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/createBudget/bloc/create_budget_bloc.dart';
import 'package:control/modules/createBudget/repository/create_budget_repository.dart';
import 'package:control/modules/createBudget/view/create_budget_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateBudgetPage extends StatelessWidget {
  const CreateBudgetPage({
    Key? key,
    required this.budgetName,
  }) : super(key: key);

  final String budgetName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        actions: [_infoButton(context)],
        bottomHeigth: FiicoPaddings.zero,
      ),
      body: BlocProvider(
        create: (context) => CreateBudgetBloc(
          CreateBudgetRepository(),
        ),
        child: CreateBudgetPageView(
          budgetName: budgetName,
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
          FiicoAlertDialog.showSuccess(
            context,
            title: FiicoLocale().myBudgets,
            message: FiicoLocale().budgetsAreControlledList,
          );
        },
        icon: const Icon(
          MdiIcons.informationOutline,
          color: FiicoColors.grayDark,
        ),
      ),
    );
  }
}

class CreateBudgetPageView extends StatelessWidget {
  const CreateBudgetPageView({
    Key? key,
    required this.budgetName,
  }) : super(key: key);

  final String budgetName;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateBudgetBloc, CreateBudgetState>(
      builder: (context, state) {
        return FutureBuilder<Budget>(
          future: _bugetToCreate(state),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CreateBudgetSuccessView(
                budgetToCreate: snapshot.requireData,
                mDebts: state.debts,
                mEntrys: state.entrys,
                users: state.users,
              );
            }
            return const LoadingView();
          },
        );
      },
      listener: (context, state) {
        _validateStatusView(context, state);
        _validateIfCompleteBudget(context, state);
      },
    );
  }

  void _validateStatusView(BuildContext context, CreateBudgetState state) {
    switch (state.status) {
      case CreateBudgetStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfCompleteBudget(
      BuildContext context, CreateBudgetState state) {
    if (state.isCompleteAdded) {
      Navigator.of(context).pop();
    }
  }

  Future<Budget> _bugetToCreate(CreateBudgetState state) async {
    final user = await Preferences.get.getUser();
    return Budget.create(
      id: const Uuid().v1(),
      currency: state.currencySelected?.code ?? user?.defaultCurrency?.code,
      name: budgetName,
      ownerName: user?.userName,
      isCycle: state.isCycle,
      cycle: state.cycle,
      startDate: state.initDate,
      finishDate: state.finishDate,
      duration: state.duration,
      movements: state.movements,
      icon: state.icon,
      users: state.users,
    );
  }
}
