import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/changeLanguage/repository/languages_list.dart';
import 'package:control/modules/changeLanguage/view/itemList/change_language_item_list.dart';
import 'package:flutter/material.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({
    Key? key,
    required this.languages,
    required this.onSelectLanguage,
  }) : super(key: key);

  final List<Language> languages;
  final Function(Language) onSelectLanguage;

  @override
  State<ChangeLanguageView> createState() => ChangeLanguageViewState();
}

class ChangeLanguageViewState extends State<ChangeLanguageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _languagesItemsList(context),
    );
  }

  Widget _languagesItemsList(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: const [
          BoxShadow(
            color: FiicoColors.grayLite,
            blurRadius: 5,
            spreadRadius: 20,
          )
        ],
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          top: FiicoPaddings.thirtyTwo,
          right: FiicoPaddings.sixteen,
          left: FiicoPaddings.sixteen,
        ),
        child: ListView.builder(
          itemCount: widget.languages.length,
          itemBuilder: (context, index) {
            final language = widget.languages[index];
            return ChangeListItemView(
              onSelectLanguage: widget.onSelectLanguage,
              language: language,
            );
          },
        ),
      ),
    );
  }
}
