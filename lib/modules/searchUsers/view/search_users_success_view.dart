import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/view/emptyView/search_users_empty_view.dart';
import 'package:control/modules/searchUsers/view/listView/search_users_item_list.dart';
import 'package:flutter/material.dart';

class SearchUsersSuccessView extends StatelessWidget {
  const SearchUsersSuccessView({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Stack(
        children: [
          _budgetsList(),
          _emptyView(),
        ],
      ),
    );
  }

  Widget _emptyView() {
    return Visibility(
      visible: users.isEmpty,
      child: const SearchUsersEmptyView(),
    );
  }

  Widget _budgetsList() {
    return Visibility(
      visible: users.isNotEmpty,
      child: Container(
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
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return SearchUserListItemView(user: user, isSelected: true);
          },
        ),
      ),
    );
  }
}
