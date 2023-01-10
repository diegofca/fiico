// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/bloc/change_language_bloc.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/change_language_repository.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/view/change_language_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocProvider(
        create: (context) => ChangeLanguageBloc(
          ChangeLanguageRepository(),
        ),
        child: ChangeLanguageView(
          onSelectLanguage: onSelectLanguage,
          languages: Languages().items,
        ),
      ),
    );
  }
}

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({
    Key? key,
    required this.languages,
    required this.onSelectLanguage,
  }) : super(key: key);

  final List<Language> languages;
  final Function(Language) onSelectLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {
      return ChangeLanguageSuccessView(
        onSelectLanguage: onSelectLanguage,
        languages: Languages().items,
      );
    });
  }
}
