import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_success_view.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: const GenericAppBar(
        text: "Notifications",
        textColor: FiicoColors.black,
        isShowBack: false,
      ),
      body: BlocProvider(
        create: (context) => MenuBloc(),
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
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        switch (state.status) {
          case MenuStatus.success:
            return const NotificationsSuccessView();
        }
      },
    );
  }
}