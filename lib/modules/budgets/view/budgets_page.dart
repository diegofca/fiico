import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/budgets/bloc/budgets_bloc.dart';
import 'package:control/modules/createBudget/view/create_budget_bottom_view.dart';
import 'package:control/modules/createBudget/view/create_budget_page.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'budgets_success_view.dart';

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale.myBudgets,
        textColor: FiicoColors.black,
        actions: [_addBudgetButton(context)],
        isShowBack: false,
      ),
      body: BlocProvider(
        create: (context) => BudgetsBloc(HomeRepository())
          ..add(BudgetsFetchRequest(uID: user?.id)),
        child: const BudgetsPageView(),
      ),
    );
  }

  Widget _addBudgetButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () => _addBudgetClickedAction(context),
        icon: const Icon(
          MdiIcons.plusCircleOutline,
          color: FiicoColors.grayDark,
        ),
      ),
    );
  }

  void _addBudgetClickedAction(BuildContext context) {
    CreateBottomView().show(context, callbackName: (name) {
      FiicoRoute.send(context, CreateBudgetPage(budgetName: name));
    });
  }
}

class BudgetsPageView extends StatelessWidget {
  const BudgetsPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetsBloc, BudgetsState>(
      builder: (context, state) {
        switch (state.status) {
          case BudgetsStatus.waiting:
            return StreamBuilder<List<Budget>>(
              stream: state.budgets,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BudgetSuccessView(
                    budgets: snapshot.requireData,
                  );
                }
                return const LoadingView(
                  backgroundColor: FiicoColors.white,
                ); // add failed view
              },
            );
        }
      },
    );
  }
}
