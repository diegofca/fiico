// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/models/setting.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/settings_success_view.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
    this.user,
    required this.settingItem,
    required this.isShowBack,
  }) : super(key: key);

  final bool isShowBack;
  final FiicoUser? user;
  final SettingItem settingItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: settingItem.name,
        textColor: FiicoColors.black,
        isShowBack: isShowBack,
      ),
      body: SettingsSuccessView(
        settingItem: settingItem,
      ),
    );
  }
}
