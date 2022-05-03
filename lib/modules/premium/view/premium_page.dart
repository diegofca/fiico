import 'package:control/models/budget.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/home/bloc/home_bloc.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:control/modules/premium/view/premium_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(HomeRepository()),
      child: PremiumPageView(user: user),
    );
  }
}

class PremiumPageView extends StatelessWidget {
  const PremiumPageView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        return StreamBuilder<List<Budget>>(
          stream: state.budgets,
          builder: (context, snapshot) {
            return const PremiumSuccessView();
          },
        );
      },
      listener: (context, state) {},
    );
  }
}
