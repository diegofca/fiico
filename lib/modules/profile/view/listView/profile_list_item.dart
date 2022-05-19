import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/editProfile/view/edit_profile_page.dart';
import 'package:control/modules/helpCenter/view/help_center_dart.dart';
import 'package:control/modules/profile/model/profile_option.dart';
import 'package:control/modules/settings/view/pages/pinCode/view/security_pin_code_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class ProfileListItemView extends StatefulWidget {
  const ProfileListItemView({
    Key? key,
    required this.option,
  }) : super(key: key);

  final ProfileOption option;

  @override
  State<ProfileListItemView> createState() => ProfileListItemViewState();
}

class ProfileListItemViewState extends State<ProfileListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onOptionTapClicked(context),
      child: Container(
        height: 60,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.sixteen,
          ),
          color: FiicoColors.white,
        ),
        margin: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _nameView(),
            _badgeView(),
            _arrowView(),
          ],
        ),
      ),
    );
  }

  Widget _nameView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.sixteen,
          left: FiicoPaddings.twenyFour,
        ),
        child: Text(
          widget.option.name,
          style: Style.subtitle.copyWith(
            color: FiicoColors.grayDark,
            fontSize: FiicoFontSize.xm,
          ),
        ),
      ),
    );
  }

  Widget _arrowView() {
    return const Padding(
      padding: EdgeInsets.only(
        right: FiicoPaddings.eight,
      ),
      child: Icon(
        Icons.keyboard_arrow_right,
        color: FiicoColors.grayDark,
      ),
    );
  }

  Widget _badgeView() {
    return SizedBox(
      width: 10,
      child: Visibility(
        visible: widget.option.isActiveBadge,
        child: const Icon(
          Icons.circle,
          color: FiicoColors.pinkRed,
          size: 10,
        ),
      ),
    );
  }

  void _onOptionTapClicked(BuildContext context) async {
    final user = await Preferences.get.getUser();
    if (widget.option.name == FiicoLocale().securityPinTitle) {
      FiicoRoute.send(context, SecurityPinCodePage(user: user));
    }
    if (widget.option.name == FiicoLocale().shareQR) {}
    if (widget.option.name == FiicoLocale().editUser) {
      FiicoRoute.send(context, EditProfilePage(user: user));
    }
    if (widget.option.name == FiicoLocale().helpCenter) {
      FiicoRoute.send(context, HelpCenterPage(user: user));
    }
  }
}
