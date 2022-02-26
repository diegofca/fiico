import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/createBudget/bloc/create_budget_bloc.dart';
import 'package:control/modules/createBudget/repository/create_budget_repository.dart';
import 'package:control/modules/createBudget/view/create_budget_success_view.dart';
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
        actions: [_dotsButton()],
        bottomHeigth: 0,
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
        switch (state.status) {
          case CreateBudgetStatus.loading:
            return const LoadingView();
          case CreateBudgetStatus.success:
            return CreateBudgetSuccessView(
              budgetToCreate: _bugetToCreate(state),
              mDebts: state.debts,
              mEntrys: state.entrys,
            );
        }
      },
      listener: (context, state) {
        if (state.isCompleteAdded) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Budget _bugetToCreate(CreateBudgetState state) => Budget.create(
        id: const Uuid().v1(),
        name: budgetName,
        currency: state.currencySelected?.code,
        isCycle: state.isCycle,
        cycle: state.cycle,
        startDate: state.initDate,
        finishDate: state.finishDate,
        duration: state.duration,
        movements: state.movements,
      );
}
