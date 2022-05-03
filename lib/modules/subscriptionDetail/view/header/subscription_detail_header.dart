import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/profile_image.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/profile/view/profile_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class SubscriptionDetailHeaderView extends StatefulWidget {
  const SubscriptionDetailHeaderView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  State<SubscriptionDetailHeaderView> createState() =>
      SubscriptionDetailHeaderViewState();
}

class SubscriptionDetailHeaderViewState
    extends State<SubscriptionDetailHeaderView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconItem(context),
          _bodyView(),
        ],
      ),
    );
  }

  Widget _iconItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
        right: FiicoPaddings.twenyFour,
        left: FiicoPaddings.twenyFour,
      ),
      child: _profileImage(context),
    );
  }

  Widget _profileImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: ProfileImage(
        user: widget.user,
        size: 60,
        onProfileTap: () => FiicoRoute.send(
          context,
          ProfilePage(user: widget.user),
        ),
      ),
    );
  }

  Widget _bodyView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_nameItemView()],
          ),
          _statusAndDate(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return Expanded(
      child: Text(
        widget.user?.currentPlan?.getPlanTitle() ?? '',
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _statusAndDate() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              color: widget.user?.currentPlan?.getStatusColor(),
              size: 12,
            ),
          ),
          Text(
            widget.user?.currentPlan?.getStatusTitle() ?? '',
            style: Style.subtitle.copyWith(
              color: FiicoColors.grayNeutral,
              fontSize: FiicoFontSize.xs,
            ),
          ),
        ],
      ),
    );
  }
}
