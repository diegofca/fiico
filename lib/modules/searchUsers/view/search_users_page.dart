import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/bloc/search_users_bloc.dart';
import 'package:control/modules/searchUsers/repository/search_users_repository.dart';
import 'package:control/modules/searchUsers/view/search_users_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchUsersPage extends StatelessWidget {
  const SearchUsersPage({
    Key? key,
    required this.users,
    required this.onUsersSelected,
  }) : super(key: key);

  final List<FiicoUser>? users;
  final Function(List<FiicoUser>?) onUsersSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchUsersBloc(
        SearchUsersRepository(),
      )..add(SearchUsersFetchRequest(users)),
      child: SearchUsersPageView(
        onUsersSelected: onUsersSelected,
      ),
    );
  }
}

class SearchUsersPageView extends StatelessWidget {
  const SearchUsersPageView({
    Key? key,
    required this.onUsersSelected,
  }) : super(key: key);

  final Function(List<FiicoUser>?) onUsersSelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchUsersBloc, SearchUsersState>(
      builder: (context, state) {
        return StreamBuilder<List<FiicoUser>>(
          stream: state.users,
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: FiicoColors.grayBackground,
              appBar: GenericAppBar(
                bottomHeigth: FiicoPaddings.zero,
                title: SizedBox(
                  width: double.maxFinite,
                  height: 60,
                  child: _searchInputView(context),
                ),
              ),
              body: SearchUsersSuccessView(
                users: state.getFilteredUsers(
                  snapshot.data,
                  state.query ?? '',
                ),
              ),
            );
          },
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case SearchUsersStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }
      },
    );
  }

  Widget _searchInputView(BuildContext context) {
    final bloc = context.read<SearchUsersBloc>();
    return Row(
      children: [
        Expanded(
          child: FiicoTextfield(
            hintText: FiicoLocale.findYourFriendsHere,
            textInputAction: TextInputAction.search,
            onChanged: (text) {
              bloc.add(SearchUsersFilterRequest(text));
            },
          ),
        ),
        IconButton(
          onPressed: () {
            onUsersSelected(bloc.state.selectedUsers);
            Navigator.of(context).pop();
          },
          icon: const Icon(
            MdiIcons.checkAll,
            color: FiicoColors.greenNeutral,
          ),
        ),
      ],
    );
  }
}
