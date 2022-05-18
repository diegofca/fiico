import 'package:control/models/user.dart';
import 'package:control/modules/premium/bloc/premium_bloc.dart';
import 'package:control/modules/premium/repository/premium_repository.dart';
import 'package:control/modules/premium/view/premium_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({
    Key? key,
    this.user,
    required this.showPlan,
  }) : super(key: key);

  final FiicoUser? user;
  final Function showPlan;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PremiumBloc(PremiumRepository()),
      child: PremiumPageView(user: user, showPlan: showPlan),
    );
  }
}

class PremiumPageView extends StatelessWidget {
  const PremiumPageView({
    Key? key,
    this.user,
    required this.showPlan,
  }) : super(key: key);

  final FiicoUser? user;
  final Function showPlan;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PremiumBloc, PremiumState>(
      builder: (context, state) {
        return const PremiumSuccessView();
      },
      listener: (context, state) async {
        if (state.isCompletePayment) {
          FiicoRoute.hideLoader(context);
          FiicoRoute.back(context);
          showPlan();
        }
      },
    );
  }
}
