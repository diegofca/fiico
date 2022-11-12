import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/friends/view/friends_page.dart';
import 'package:control/modules/search/bloc/search_bloc.dart';
import 'package:control/modules/searchUsers/view/listView/search_users_item_list.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUsersListView extends StatelessWidget {
  const SearchUsersListView({
    Key? key,
    required this.users,
    required this.friends,
    required this.invites,
    required this.requestInvites,
  }) : super(key: key);

  final items = 20;
  final List<FiicoUser> users;
  final List<FiicoUser> friends;
  final List<InviteFriend> invites;
  final List<InviteFriend> requestInvites;

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
      height: _getListhHeigth(),
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
          return Column(
            children: [
              _searchUserCell(user),
              _addedFriendButton(context, user),
            ],
          );
        },
      ),
    );
  }

  Widget _searchUserCell(FiicoUser user) {
    return SearchUserListItemView(
      user: user,
      isSelected: false,
      isClickeable: false,
    );
  }

  Widget _addedFriendButton(BuildContext context, FiicoUser user) {
    Widget buttonAction = FiicoButton(
      image: SVGImages.addFriend,
      title: FiicoLocale().addFriend,
      textColor: FiicoColors.gold,
      borderColor: FiicoColors.gold,
      color: FiicoColors.white,
      onTap: () {
        context.read<SearchBloc>().add(SendRequestFriendRequest(user: user));
      },
    );

    if (_isMyFriend(user) || _isPendingOrSuccessRequestInvite(user)) {
      buttonAction = Container();
    }

    if (_isPendingOrSuccessInvite(user)) {
      buttonAction = _pendingInviteView(context);
    }

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        left: FiicoPaddings.sixteen,
        right: FiicoPaddings.sixteen,
      ),
      child: buttonAction,
    );
  }

  Widget _pendingInviteView(BuildContext context) {
    return FiicoButton(
      title: FiicoLocale().showInvite,
      textColor: FiicoColors.white,
      color: FiicoColors.purpleNeutral,
      onTap: () async {
        final user = await Preferences.get.getUser();
        FiicoRoute.send(context, FriendsPage(user: user));
      },
    );
  }

  bool _isMyFriend(FiicoUser user) {
    return friends.map((e) => e.id == user.id).isNotEmpty;
  }

  bool _isPendingOrSuccessInvite(FiicoUser user) {
    return invites.where((e) => e.sendUserId == user.id).toList().isNotEmpty;
  }

  bool _isPendingOrSuccessRequestInvite(FiicoUser user) {
    return requestInvites
        .where((e) => e.receivedUserId == user.id)
        .toList()
        .isNotEmpty;
  }

  double _getListhHeigth() {
    double heigth = 0;
    for (var u in users) {
      final newheigth = _isMyFriend(u) || _isPendingOrSuccessRequestInvite(u)
          ? _heigthCell
          : 180;
      heigth = heigth + newheigth;
    }
    return heigth;
  }
}
