import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/setting.dart';
import 'package:control/modules/helpCenter/view/help_center_dart.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/view/send_suggestion_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class SettingsContactConfiguration {
  final BuildContext context;

  SettingsContactConfiguration(this.context);

// SECURITY GROUP SETTINGS  ----------------------------------------------------
  /// CONTACT GROUP INFORMATION ------------------------------------------------
  SettingItem contact() => SettingItem(
        name: FiicoLocale().contact.toUpperCase(),
        childs: [
          SettingItem(
            name: FiicoLocale().helpCenter,
            onTap: () async {
              final user = await Preferences.get.getUser();
              FiicoRoute.send(context, HelpCenterPage(user: user));
            },
          ),
          SettingItem(
            name: FiicoLocale().sendSuggestion,
            onTap: () => FiicoRoute.send(context, const SendSuggestionPage()),
          ),
          SettingItem(
            name: FiicoLocale().rateValiu,
            onTap: () {
              print('ir a mi subscripcion');
            },
          ),
          SettingItem(
            name: FiicoLocale().shareButton,
            onTap: () {
              print('ir a mi subscripcion');
            },
          ),
        ],
      );
}
