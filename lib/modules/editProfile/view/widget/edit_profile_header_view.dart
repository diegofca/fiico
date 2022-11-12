import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/profile_image.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/profile/view/profile_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class EditProfileHeaderView extends StatefulWidget {
  const EditProfileHeaderView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  State<EditProfileHeaderView> createState() => EditProfileHeaderViewState();
}

class EditProfileHeaderViewState extends State<EditProfileHeaderView> {
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
          _lastNameView(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return Expanded(
      child: Text(
        '${widget.user?.firstName} ${widget.user?.lastName}',
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _lastNameView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.eight),
      child: Text(
        widget.user?.userName ?? '',
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }
}
