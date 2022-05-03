import 'package:control/models/setting.dart';
import 'package:flutter/material.dart';

class SettingsInfoConfiguration {
  final BuildContext context;

  SettingsInfoConfiguration(this.context);

  /// INFO GROUP INFORMATION ---------------------------------------------------
  SettingItem info() => SettingItem(
        name: 'INFORMACIÓN',
        childs: [
          SettingItem(
            name: 'Cambiar idioma',
            onTap: () {
              print('ir a seguridad');
            },
          ),
          SettingItem(
            name: 'Ultima actualización',
            onTap: () {
              print('ir a seguridad');
            },
          ),
          SettingItem(
            name: 'Acerca de Valiu',
            onTap: () {
              print('ir a mi subscripcion');
            },
          ),
        ],
      );
}
