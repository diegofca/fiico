import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Language {
  final String name;
  final String flag;
  final Locale locale;

  Language({required this.name, required this.flag, required this.locale});
}

class Languages {
  final items = [
    Language(
      name: FiicoLocale().english,
      flag: FlagIcons.united_kingdom,
      locale: const Locale('en', 'US'),
    ),
    Language(
      name: FiicoLocale().spanish,
      flag: FlagIcons.spain,
      locale: const Locale('es', 'SP'),
    )
  ];
}
