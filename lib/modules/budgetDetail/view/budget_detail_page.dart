import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgetDetail/bloc/budget_detail_bloc.dart';
import 'package:control/modules/budgetDetail/repository/budget_detail_repository.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_success_view.dart';
import 'package:control/modules/budgetDetail/view/widgets/budget_detail_bottom_view.dart';
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
      )..add(const BudgetDetailFetchRequest(uID: 1)),
      child: BudgetDetailPageView(
        budget: budget,
      ),
    );
  }
}

class BudgetDetailPageView extends StatelessWidget {
  const BudgetDetailPageView({
    Key? key,
    required this.budget,
  }) : super(key: key);

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BudgetDetailBloc, BudgetDetailState>(
      builder: (context, state) {
        return _bodyContainer(state.budget);
      },
      listener: (context, state) {
        switch (state.status) {
          case BudgetDetailStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }
        if (state.isDeletedBudget) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget _bodyContainer(Stream<Budget>? budget) {
    return StreamBuilder<Budget>(
      stream: budget,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: FiicoColors.grayBackground,
            appBar: GenericAppBar(
              actions: [_dotsButton(context)],
              bottomHeigth: 0,
            ),
            body: BudgetDetailSuccessView(
              budget: snapshot.requireData,
            ),
          );
        }
        return const LoadingView(); // add failed view
      },
    );
  }

  Widget _dotsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          BudgetDetailBottomView().show(
            context,
            onOptionSelected: (option) => _selectedOption(context, option),
          );
        },
        icon: const Icon(
          MdiIcons.dotsHorizontal,
          color: Colors.black,
        ),
      ),
    );
  }

  void _selectedOption(BuildContext context, BudgetDetailBottomOption option) {
    switch (option) {
      case BudgetDetailBottomOption.delete_budget:
        context
            .read<BudgetDetailBloc>()
            .add(BudgetDetailDeleteRequest(budget: budget));
        break;
      case BudgetDetailBottomOption.add_friend:
        break;
    }
  }
}
