import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/bloc/search_users_bloc.dart';
import 'package:control/modules/searchUsers/repository/search_users_repository.dart';
import 'package:control/modules/searchUsers/view/search_users_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUsersPage extends StatelessWidget {
  const SearchUsersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        bottomHeigth: 0,
        title: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: FiicoTextfield(
            hintText: "Busca y agrega tus amigos aqui ..",
            textInputAction: TextInputAction.search,
            onChanged: (text) {
              context
                  .read<SearchUsersBloc>()
                  .add(SearchUsersFilterRequest(text));
            },
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => context.read<SearchUsersBloc>(),
        child: const SearchUsersPageView(),
      ),
    );
  }
}

class SearchUsersPageView extends StatelessWidget {
  const SearchUsersPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsersBloc, SearchUsersState>(
      builder: (context, state) {
        switch (state.status) {
          case SearchUsersStatus.success:
            return StreamBuilder<List<User>>(
              stream: state.users,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SearchUsersSuccessView(
                    users: _getFilteredUsers(snapshot.requireData, state.query),
                  );
                }
                return const LoadingView();
              },
            );
          case SearchUsersStatus.searching:
          case SearchUsersStatus.waiting:
            return const LoadingView(
              backgroundColor: FiicoColors.pink,
            );
        }
      },
    );
  }

  List<User> _getFilteredUsers(List<User>? users, String? query) {
    final _users = users ?? [];
    if (query != null) {
      return _users
          .where(
            (e) =>
                e.firstName!.contains(query) ||
                e.lastName!.contains(query) ||
                e.userName!.contains(query) ||
                e.email!.contains(query),
          )
          .toList();
    }
    return _users;
  }
}
