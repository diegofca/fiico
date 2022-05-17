import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/profile/model/profile_option.dart';
import 'package:control/modules/profile/view/listView/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileSuccessView extends StatelessWidget {
  ProfileSuccessView({
    Key? key,
  }) : super(key: key);

  final items = 10;

  final List<ProfileOption> options = [
    ProfileOption(FiicoLocale().editUser, false),
    ProfileOption(FiicoLocale().notifications, true),
    ProfileOption(FiicoLocale().securityPinTitle, false),
    ProfileOption(FiicoLocale().shareQR, false),
    ProfileOption(FiicoLocale().helpCenter, false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: FiicoColors.grayBackground,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _notificationsList(),
              _iconAppVersion(),
              _logOutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationsList() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      decoration: BoxDecoration(
        color: FiicoColors.grayBackground,
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
        itemCount: options.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final option = options[index];
          return ProfileListItemView(option: option);
        },
      ),
    );
  }

  Widget _iconAppVersion() {
    return Container(
      width: double.maxFinite,
      height: 60,
      color: FiicoColors.grayBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            SVGImages.valiuIcon,
            color: FiicoColors.grayNeutral,
            height: 25,
          ),
          Text(
            'Versión 1.0.0',
            style: Style.subtitle.copyWith(
              color: FiicoColors.grayNeutral,
              fontSize: FiicoFontSize.xs,
            ),
          )
        ],
      ),
    );
  }

  Widget _logOutButton(BuildContext context) {
    return FiicoButton(
      title: FiicoLocale().logOut,
      color: FiicoColors.pink,
      onTap: () {
        Preferences.get.logOut(context);
      },
    );
  }
}
