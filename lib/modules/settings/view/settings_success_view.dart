import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/settings/settings_item.dart';
import 'package:control/modules/settings/view/widget/settings_item_list.dart';
import 'package:flutter/material.dart';

class SettingsSuccessView extends StatelessWidget {
  const SettingsSuccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _settingsItemsList(context),
    );
  }

  Widget _settingsItemsList(BuildContext context) {
    return Container(
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          top: FiicoPaddings.thirtyTwo,
          right: FiicoPaddings.sixteen,
          left: FiicoPaddings.sixteen,
        ),
        child: ListView.builder(
          itemCount: settingsGroup.length,
          itemBuilder: (context, index) {
            final group = settingsGroup[index];
            return SettingsListItemView(settingGroup: group);
          },
        ),
      ),
    );
  }
}
