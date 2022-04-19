import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/bloc/search_users_bloc.dart';
import 'package:control/modules/searchUsers/view/emptyView/search_users_empty_view.dart';
import 'package:control/modules/searchUsers/view/listView/search_users_item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class SearchUsersSuccessView extends StatelessWidget {
  const SearchUsersSuccessView({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<FiicoUser> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Stack(
        children: [
          _budgetsList(context),
          _emptyView(context),
        ],
      ),
    );
  }

  Widget _emptyView(BuildContext context) {
    return Visibility(
      visible: users.isEmpty,
      child: const SearchUsersEmptyView(),
    );
  }

  Widget _budgetsList(BuildContext context) {
    return Visibility(
      visible: users.isNotEmpty,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: const [
            BoxShadow(
              color: FiicoColors.grayLite,
              blurRadius: 5,
              spreadRadius: 20,
            )
          ],
        ),
        child: ListView.builder(
          itemCount: getCombineUsers(context).length,
          itemBuilder: (context, index) {
            final user = getCombineUsers(context)[index];
            return itemUserView(context, user);
          },
        ),
      ),
    );
  }

  List<FiicoUser> getCombineUsers(BuildContext context) {
    final selectedUsers =
        context.read<SearchUsersBloc>().state.selectedUsers ?? [];
    return {...selectedUsers, ...users}
        .toList()
        .sortedBy<String>((e) => e.firstName!);
  }

  Widget itemUserView(BuildContext context, FiicoUser user) {
    final selectedUsers = context.read<SearchUsersBloc>().state.selectedUsers;
    final selected = selectedUsers?.contains(user) ?? false;
    return SearchUserListItemView(user: user, isSelected: selected);
  }
}
