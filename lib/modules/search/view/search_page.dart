import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/search/bloc/search_bloc.dart';
import 'package:control/modules/search/repository/search_repository.dart';
import 'package:control/modules/search/view/search_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        SearchRepository(),
      )..add(SearchUsersRequest(query)),
      child: const SearchPageView(),
    );
  }
}

class SearchPageView extends StatelessWidget {
  const SearchPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchStatus.success:
            return _bodyContainer(context, state);
          case SearchStatus.searching:
            return const LoadingView();
          case SearchStatus.waiting:
            return const LoadingView();
        }
      },
    );
  }

  Widget _bodyContainer(BuildContext context, SearchState state) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: "${FiicoLocale().resultsOf} ${state.query}",
        textColor: FiicoColors.graySoft,
      ),
      body: SearchSuccessView(
        usersStream: state.users,
        budgetsStream: state.budgets,
        movementsStream: state.movements,
      ),
    );
  }
}
