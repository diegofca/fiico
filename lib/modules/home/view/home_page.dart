// ignore_for_file: must_be_immutable

import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/home/bloc/home_bloc.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:control/modules/home/view/home_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(HomeRepository())
        ..add(const HomeBudgetsFetchRequest(uID: 1)),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.init:
            return StreamBuilder<List<Budget>>(
              stream: state.budgets,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomeSuccesView(
                    budgets: snapshot.requireData,
                    budgetSelected: state.budgetSelected,
                    dropdownvalue: state.filter ?? 0,
                  );
                }
                return const LoadingView(); // add failed view
              },
            );
          case HomeStatus.loading:
            return const LoadingView(); // add failed view
        }
      },
    );
  }
}
