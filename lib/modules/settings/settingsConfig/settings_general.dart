import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/models/setting.dart';
import 'package:control/modules/premium/view/premium_page.dart';
import 'package:control/modules/settings/settingsConfig/settings_contact.dart';
import 'package:control/modules/settings/settingsConfig/settings_info.dart';
import 'package:control/modules/settings/settingsConfig/settings_security.dart';
import 'package:control/modules/settings/view/settings_page.dart';
import 'package:control/modules/subscriptionDetail/view/subscription_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsConfiguration {
  final BuildContext context;

  SettingsConfiguration(this.context);

  SettingItem get setting => SettingItem(name: 'Settings', childs: [
        _general(),
        SettingsInfoConfiguration(context).info(),
        SettingsContactConfiguration(context).contact()
      ]);

// GENERAL GROUP SETTINGS  -----------------------------------------------------
  SettingItem _general() => SettingItem(name: 'GENERAL', childs: [
        _security(),
        _valiuPremium(),
      ]);

  // Security item
  SettingItem _security() => SettingItem(
        name: 'Seguridad',
        onTap: () async {
          final user = await Preferences.get.getUser();
          FiicoRoute.send(
            context,
            SettingsPage(
              user: user,
              settingItem: SettingsSecurityConfiguration(context).security(),
              isShowBack: true,
            ),
          );
        },
      );

  // valiuPremium item
  SettingItem _valiuPremium() => SettingItem(
        name: 'Valiu Premium',
        icon: const Icon(
          MdiIcons.crown,
          color: FiicoColors.gold,
        ),
        onTap: () async {
          final user = await Preferences.get.getUser();
          final isPremium = user?.isPremium() ?? false;
          final page = isPremium
              ? SubscriptionDetailPage(user: user)
              : const PremiumPage();
          FiicoRoute.send(context, page);
        },
      );
}
