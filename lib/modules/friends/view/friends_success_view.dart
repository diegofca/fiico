import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/friends/view/emptyView/friends_empty_view.dart';
import 'package:control/modules/friends/view/listView/friends_user_item_list.dart';
import 'package:control/modules/searchUsers/view/listView/search_users_item_list.dart';
import 'package:flutter/material.dart';

class FriendsSuccessView extends StatelessWidget {
  const FriendsSuccessView({
    Key? key,
    required this.invitations,
    required this.friends,
  }) : super(key: key);

  final List<InviteFriend> invitations;
  final List<FiicoUser> friends;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Stack(
        children: [
          _emptyView(context),
          Column(
            children: [
              _friendList(),
              _spacingInLists(),
              _invitationList(),
            ],
          )
        ],
      ),
    );
  }

  Widget _emptyView(BuildContext context) {
    return Visibility(
      visible: invitations.isEmpty && friends.isEmpty,
      child: const FriendsEmptyView(),
    );
  }

  Widget _spacingInLists() {
    double height = friends.isNotEmpty && invitations.isNotEmpty ? 100 : 0;
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      child: Text(
        FiicoLocale().invitations,
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.black,
        ),
      ),
    );
  }

  Widget _friendList() {
    return Visibility(
      visible: friends.isNotEmpty,
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
          shrinkWrap: true,
          itemCount: friends.length,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final user = friends[index];
            return SearchUserListItemView(
              user: user,
              isSelected: false,
              isClickeable: false,
            );
          },
        ),
      ),
    );
  }

  Widget _invitationList() {
    return Visibility(
      visible: invitations.isNotEmpty,
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
          shrinkWrap: true,
          itemCount: invitations.length,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final invitation = invitations[index];
            return InvitationUserListItemView(
              invitation: invitation,
            );
          },
        ),
      ),
    );
  }
}
