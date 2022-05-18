import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/view/listView/search_users_item_list.dart';
import 'package:flutter/material.dart';

class SearchUsersListView extends StatelessWidget {
  const SearchUsersListView({
    Key? key,
    required this.users,
  }) : super(key: key);

  final items = 20;
  final List<FiicoUser> users;

  final double _heigthCell = 90.0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: users.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
          right: FiicoPaddings.thirtyTwo,
          left: FiicoPaddings.thirtyTwo,
          bottom: FiicoPaddings.fourtySix,
        ),
        child: Wrap(
          children: [
            _headerView(),
            _listItemsView(),
          ],
        ),
      ),
    );
  }

  Widget _headerView() {
    return Container(
      height: 40,
      alignment: Alignment.topLeft,
      child: Text(
        '${FiicoLocale().foundUsers} (${users.length})',
        style: Style.subtitle,
      ),
    );
  }

  Widget _listItemsView() {
    return Container(
      height: users.length * _heigthCell,
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
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return SearchUserListItemView(user: user, isSelected: false);
        },
      ),
    );
  }
}
