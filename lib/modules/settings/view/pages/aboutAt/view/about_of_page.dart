import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/pages_names.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/settings/view/pages/aboutAt/view/about_of_success_view.dart';
import 'package:control/modules/subscriptionDetail/bloc/subscription_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutOfPage extends StatelessWidget {
  const AboutOfPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => SubscriptionDetailBloc(),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.budgetPage,
        child: const AboutOfPageView(),
      ),
    );
  }
}

class AboutOfPageView extends StatelessWidget {
  const AboutOfPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, info) {
        return _bodyContainer(context, info.data?.version);
      },
    );
  }

  Widget _bodyContainer(BuildContext context, String? version) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: const GenericAppBar(bottomHeigth: FiicoPaddings.zero),
      body: AboutOfSuccessView(version: version),
    );
  }
}
