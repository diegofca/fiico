// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/view/change_language_success_view.dart';
import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({
    Key? key,
    this.user,
    required this.onSelectLanguage,
  }) : super(key: key);

  final FiicoUser? user;
  final Function(Language) onSelectLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().changeLanguage,
        textColor: FiicoColors.black,
      ),
      body: ChangeLanguageView(
        onSelectLanguage: onSelectLanguage,
        languages: Languages().items,
      ),
    );
  }
}
