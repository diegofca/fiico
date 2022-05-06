import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/pages_names.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/subscriptionDetail/bloc/subscription_detail_bloc.dart';
import 'package:control/modules/subscriptionDetail/view/subscription_detail_sucess_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SubscriptionDetailPage extends StatelessWidget {
  const SubscriptionDetailPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => SubscriptionDetailBloc(),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.budgetPage,
        child: BudgetDetailPageView(user: user),
      ),
    );
  }
}

class BudgetDetailPageView extends StatelessWidget {
  const BudgetDetailPageView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionDetailBloc, SubscriptionDetailState>(
      builder: (context, state) {
        return _bodyContainer(context);
      },
      listener: (context, state) {},
    );
  }

  Widget _bodyContainer(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        actions: [_infoButton(context)],
        bottomHeigth: FiicoPaddings.zero,
      ),
      body: SubscriptionDetailSuccessView(user: user),
    );
  }

  Widget _infoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {},
        icon: const Icon(
          MdiIcons.informationOutline,
          color: Colors.black,
        ),
      ),
    );
  }

  void _selectedOption(BuildContext context) {}
}
