import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/setting.dart';
import 'package:control/modules/settings/view/pages/biometricID/view/biometric_id_page.dart';
import 'package:control/modules/settings/view/pages/pinCode/view/security_pin_code_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class SettingsSecurityConfiguration {
  final BuildContext context;

  SettingsSecurityConfiguration(this.context);

// SECURITY GROUP SETTINGS  ----------------------------------------------------
  SettingItem security() => SettingItem(
        name: 'Seguridad',
        childs: [
          SettingItem(name: 'Configurar seguridad', childs: [
            _pinCode(),
            _faceID(),
          ]),
        ],
      );

  // Pincode item
  SettingItem _pinCode() => SettingItem(
        name: 'Código de seguridad',
        onTap: () async {
          final user = await Preferences.get.getUser();
          FiicoRoute.send(context, SecurityPinCodePage(user: user));
        },
      );

  // FaceID item
  SettingItem _faceID() => SettingItem(
        name: 'Face ID - Touch ID',
        onTap: () async {
          final user = await Preferences.get.getUser();
          FiicoRoute.send(context, BiometricIDPage(user: user));
        },
      );
}
