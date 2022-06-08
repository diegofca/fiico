import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/budgetsArchiveds/bloc/budgets_archived_bloc.dart';
import 'package:control/modules/budgetsArchiveds/repository/budgets_archived_repository.dart';
import 'package:control/modules/budgetsArchiveds/view/budgets_archived_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetsArchivedPage extends StatelessWidget {
  const BudgetsArchivedPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().archivedBudgets,
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => BudgetsArchivedBloc(
          BudgetsArchivedRepository(),
        )..add(BudgetsArchivedFetchRequest(uID: user?.id)),
        child: const BudgetsArchivedPageView(),
      ),
    );
  }
}

class BudgetsArchivedPageView extends StatelessWidget {
  const BudgetsArchivedPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetsArchivedBloc, BudgetsArchivedState>(
      builder: (context, state) {
        switch (state.status) {
          case BudgetsArchivedStatus.waiting:
            return StreamBuilder<List<Budget>>(
              stream: state.budgets,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BudgetArchivedSuccessView(
                    budgets: snapshot.requireData,
                  );
                }
                return const LoadingView(
                  backgroundColor: FiicoColors.white,
                );
              },
            );
        }
      },
    );
  }
}
