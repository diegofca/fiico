// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_profile_image.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/modules/friends/bloc/friends_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvitationUserListItemView extends StatefulWidget {
  InvitationUserListItemView({
    Key? key,
    required this.invitation,
  }) : super(key: key);

  InviteFriend invitation;

  @override
  State<InvitationUserListItemView> createState() =>
      FInvitationUserListItemViewState();
}

class FInvitationUserListItemViewState
    extends State<InvitationUserListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        color: Colors.white.withOpacity(0),
        width: double.maxFinite,
        child: Column(
          children: [
            _bodyUser(),
            _requestButtonView(context),
            _bottomLineView()
          ],
        ),
      ),
    );
  }

  Widget _bodyUser() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconView(),
          _userDataView(),
        ],
      ),
    );
  }

  Widget _iconView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
        left: FiicoPaddings.sixteen,
      ),
      child: Container(
        width: 30,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
          color: FiicoColors.white,
        ),
        child: const FiicoProfileNetwork.user(),
      ),
    );
  }

  Widget _userDataView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(FiicoPaddings.sixteen),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _nameView(),
            _requestLabelView(),
          ],
        ),
      ),
    );
  }

  Widget _nameView() {
    return Text(
      widget.invitation.sendUserName ?? '',
      maxLines: FiicoMaxLines.ten,
      style: Style.title.copyWith(
        color: FiicoColors.grayDark,
        fontSize: FiicoFontSize.xm,
      ),
    );
  }

  Widget _requestLabelView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.four),
      child: Wrap(
        children: [
          Text(
            'te enviado una solicitud de amistad.',
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestButtonView(BuildContext context) {
    return Container(
      width: double.maxFinite,
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          _rejectedInvitationButton(context),
          _acceptInvitationButton(context),
        ],
      ),
    );
  }

  Widget _acceptInvitationButton(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
          right: FiicoPaddings.sixteen,
        ),
        child: FiicoButton(
          title: 'Aceptar',
          textColor: FiicoColors.gold,
          borderColor: FiicoColors.gold,
          color: FiicoColors.white,
          onTap: () {
            context
                .read<FriendsBloc>()
                .add(AcceptedInvitationRequest(invite: widget.invitation));
          },
        ),
      ),
    );
  }

  Widget _rejectedInvitationButton(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
          right: FiicoPaddings.sixteen,
        ),
        child: FiicoButton(
          title: 'Rechazar',
          textColor: FiicoColors.pinkRed,
          borderColor: FiicoColors.pinkRed,
          color: FiicoColors.white,
          onTap: () {
            context
                .read<FriendsBloc>()
                .add(RejectedInvitationRequest(invite: widget.invitation));
          },
        ),
      ),
    );
  }

  Widget _bottomLineView() {
    return Container(
      margin: const EdgeInsets.only(top: FiicoPaddings.eight),
      width: double.maxFinite,
      color: FiicoColors.grayLite,
      height: 2,
    );
  }
}
