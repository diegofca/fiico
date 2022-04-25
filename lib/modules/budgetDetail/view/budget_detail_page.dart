import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgetDetail/bloc/budget_detail_bloc.dart';
import 'package:control/modules/budgetDetail/repository/budget_detail_repository.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_success_view.dart';
import 'package:control/modules/budgetDetail/view/widgets/budget_detail_bottom_view.dart';
import 'package:control/modules/searchUsers/view/search_users_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BudgetDetailPage extends StatelessWidget {
  const BudgetDetailPage({
    Key? key,
    required this.budget,
  }) : super(key: key);

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => BudgetDetailBloc(
        BudgetDetailRepository(budget.id),
      )..add(BudgetDetailFetchRequest(budget: budget)),
      child: const BudgetDetailPageView(),
    );
  }
}

class BudgetDetailPageView extends StatelessWidget {
  const BudgetDetailPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BudgetDetailBloc, BudgetDetailState>(
      builder: (context, state) {
        return _bodyContainer(state.budget);
      },
      listener: (context, state) {
        _validateStatusView(context, state);
        _validateIfDeleteBudget(context, state);
      },
    );
  }

  Widget _bodyContainer(Stream<Budget>? budget) {
    return StreamBuilder<Budget>(
      stream: budget,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final newBudget = snapshot.requireData;
          return Scaffold(
            backgroundColor: FiicoColors.grayBackground,
            appBar: GenericAppBar(
              actions: [_dotsButton(context, newBudget)],
              bottomHeigth: 0,
            ),
            body: BudgetDetailSuccessView(
              budget: newBudget,
            ),
          );
        }
        return const LoadingView(); // add failed view
      },
    );
  }

  Widget _dotsButton(BuildContext context, Budget budget) {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          BudgetDetailBottomView().show(
            context,
            budget: budget,
            onOptionSelected: (option) =>
                _selectedOption(context, budget, option),
          );
        },
        icon: const Icon(
          MdiIcons.dotsHorizontal,
          color: Colors.black,
        ),
      ),
    );
  }

  void _validateStatusView(BuildContext context, BudgetDetailState state) {
    switch (state.status) {
      case BudgetDetailStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfDeleteBudget(BuildContext context, BudgetDetailState state) {
    if (state.isDeletedBudget) {
      Navigator.of(context).pop();
    }
  }

  void _selectedOption(
      BuildContext context, Budget budget, BudgetDetailBottomOption option) {
    switch (option) {
      case BudgetDetailBottomOption.delete_budget:
        context
            .read<BudgetDetailBloc>()
            .add(BudgetDetailDeleteRequest(budget: budget));
        break;
      case BudgetDetailBottomOption.add_friend:
        FiicoRoute.send(
          context,
          SearchUsersPage(
            users: budget.users,
            onUsersSelected: (users) => context.read<BudgetDetailBloc>().add(
                BudgetUpdateDetailUsersSelected(users: users, budget: budget)),
          ),
        );
        break;
      case BudgetDetailBottomOption.exit_budget:
        break;
    }
  }
}
