import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
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
    return BlocBuilder<CreateBudgetBloc, CreateBudgetState>(
      builder: (context, state) {
        switch (state.status) {
          case CreateBudgetStatus.success:
          case CreateBudgetStatus.loading:
            return CreateBudgetSuccessView(
              budgetToCreate: _bugetToCreate(state.currencySelected?.code),
              mDebts: state.debts,
              mEntrys: state.entrys,
            );
        }
      },
    );
  }

  Budget _bugetToCreate(String? currency) => Budget.create(
        id: const Uuid().v1(),
        name: budgetName,
        currency: currency,
      );
}
