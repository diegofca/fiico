import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/modules/profile/model/profile_option.dart';
import 'package:control/modules/profile/view/listView/profile_list_item.dart';
import 'package:flutter/material.dart';

class ProfileSuccessView extends StatelessWidget {
  ProfileSuccessView({
    Key? key,
  }) : super(key: key);

  final items = 10;

  final List<ProfileOption> options = [
    ProfileOption(
      "Actualizar datos",
      ProfileOptionDetail(
        SVGImages.addBudget,
        true,
      ),
    ),
    ProfileOption(
      "Notificaciones",
      ProfileOptionDetail(
        SVGImages.addBudget,
        false,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _notificationsList(),
          FiicoButton(
            title: "Cerrar sesión",
            color: FiicoColors.gold,
            onTap: () {
              Preferences.get.logOut(context);
            },
          )
        ],
      ),
    );
  }

  Widget _notificationsList() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
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
}
