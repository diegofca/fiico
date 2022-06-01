import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/setting.dart';
import 'package:control/modules/settings/view/pages/aboutAt/view/about_of_page.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/view/change_language_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class SettingsInfoConfiguration {
  final BuildContext context;

  SettingsInfoConfiguration(this.context);

  /// INFO GROUP INFORMATION ---------------------------------------------------
  SettingItem info() => SettingItem(
        name: FiicoLocale().information.toUpperCase(),
        childs: [
          SettingItem(
            name: FiicoLocale().changeLanguage,
            onTap: () => FiicoRoute.send(
              context,
              ChangeLanguagePage(
                onSelectLanguage: (lang) {
                  FiicoRoute.changeTab(context, TabOption.home);
                },
              ),
            ),
          ),
          SettingItem(
            name: FiicoLocale().aboutOfValiu,
            onTap: () => FiicoRoute.send(context, const AboutOfPage()),
          ),
        ],
      );
}
