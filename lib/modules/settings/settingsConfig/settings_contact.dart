import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/setting.dart';
import 'package:flutter/material.dart';

class SettingsContactConfiguration {
  final BuildContext context;

  SettingsContactConfiguration(this.context);

// SECURITY GROUP SETTINGS  ----------------------------------------------------
  /// CONTACT GROUP INFORMATION ------------------------------------------------
  SettingItem contact() => SettingItem(
        name: FiicoLocale.contact.toUpperCase(),
        childs: [
          SettingItem(
            name: 'Centro de ayuda',
            onTap: () {
              print('ir a seguridad');
            },
          ),
          SettingItem(
            name: 'Enviar sugerencia',
            onTap: () {
              print('ir a seguridad');
            },
          ),
          SettingItem(
            name: 'Calificar Valiu',
            onTap: () {
              print('ir a mi subscripcion');
            },
          ),
          SettingItem(
            name: 'Compartir',
            onTap: () {
              print('ir a mi subscripcion');
            },
          ),
        ],
      );
}
