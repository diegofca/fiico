import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
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
    ProfileOption("Editar usuario", false),
    ProfileOption("Notificaciones", true),
    ProfileOption("Código de seguridad", false),
    ProfileOption("Compartir QR", false),
    ProfileOption("Centro de ayuda", false),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.maxFinite,
        color: FiicoColors.grayBackground,
        child: Column(
          children: [
            _notificationsList(),
            _iconAppVersion(),
            _logOutButton(context)
          ],
        ),
      ),
    );
  }

  Widget _notificationsList() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
        decoration: BoxDecoration(
          color: Colors.transparent,
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
          itemBuilder: (context, index) {
            final option = options[index];
            return ProfileListItemView(option: option);
          },
        ),
      ),
    );
  }

  Widget _iconAppVersion() {
    return SizedBox(
      width: double.maxFinite,
      height: 60,
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
      title: "Cerrar sesión",
      color: FiicoColors.pink,
      onTap: () {
        Preferences.get.logOut(context);
      },
    );
  }
}
