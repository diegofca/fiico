import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageManager {
  static void setLanguage(Language language) {
    FiicoLocale.locale = language.locale;
    Preferences.get.saveLang(language);
  }

  static void setLanguageLogged(BuildContext context, FiicoUser? user) async {
    final languageCode = user?.languageCode ?? '';
    if (languageCode.isNotEmpty) {
      final locale = Locale(languageCode);
      final language = Languages().items.firstWhere(
            (e) => e.locale.languageCode == locale.languageCode,
          );
      FiicoLocale.locale = language.locale;
      Preferences.get.saveLang(language);
      await context.setLocale(FiicoLocale.locale);
    }
  }
}
