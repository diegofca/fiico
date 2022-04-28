import 'package:control/helpers/extension/colors.dart';
import 'package:control/models/setting.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final List<SettingGroup> settingsGroup = [
  _generalGroupSettings,
  _infoGroupSettings,
  _contactGroupSettings
];

// GENERAL GROUP SETTINGS
final _generalGroupSettings = SettingGroup(name: 'GENERAL', items: [
  SettingItem(
    name: 'Seguridad',
    onTap: () {
      print('ir a seguridad');
    },
  ),
  SettingItem(
    name: 'Mi subscripción',
    onTap: () {
      print('ir a mi subscripcion');
    },
  ),
  SettingItem(
    name: 'Consigue Valiu Premium',
    icon: const Icon(
      MdiIcons.starSettings,
      color: FiicoColors.gold,
    ),
    onTap: () {
      print('ir a seguridad');
    },
  ),
]);

/// GENERAL GROUP INFORMATION
final _infoGroupSettings = SettingGroup(name: 'INFORMACIÓN', items: [
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
]);

final _contactGroupSettings = SettingGroup(name: 'CONTACTO', items: [
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
]);
