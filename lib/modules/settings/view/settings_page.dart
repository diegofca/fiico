import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/budgets/bloc/budgets_bloc.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:control/modules/settings/view/settings_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: "Settings",
        textColor: FiicoColors.black,
        actions: [_infoButton(context)],
        isShowBack: false,
      ),
      body: BlocProvider(
        create: (context) => BudgetsBloc(HomeRepository())
          ..add(BudgetsFetchRequest(uID: user?.id)),
        child: const BudgetsPageView(),
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
          FiicoAlertDialog.showInfo(
            context,
            title: 'Configuración',
            message: 'Recuerda mejorar la seguridad de tu aplicación.',
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
                  return const SettingsSuccessView();
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
