import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgets/bloc/budgets_bloc.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'budgets_success_view.dart';

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: const GenericAppBar(
        text: "Budgets",
        textColor: FiicoColors.black,
        isShowBack: false,
      ),
      body: BlocProvider(
        create: (context) => BudgetsBloc(HomeRepository())
          ..add(const BudgetsFetchRequest(uID: 1)),
        child: const BudgetsPageView(),
      ),
    );
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
