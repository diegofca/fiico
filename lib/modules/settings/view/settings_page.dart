// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/setting.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/settings_success_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        actions: [_infoButton(context)],
        isShowBack: isShowBack,
      ),
      body: SettingsSuccessView(
        settingItem: settingItem,
      ),
    );
  }

  Widget _infoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          FiicoAlertDialog.showInfo(
            context,
            title: FiicoLocale().settings,
            message: 'Recuerda mejorar la seguridad de tu aplicación.',
          );
        },
        icon: const Icon(
          MdiIcons.informationOutline,
          color: FiicoColors.grayDark,
        ),
      ),
    );
  }
}
