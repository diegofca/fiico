import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/changeLanguage/repository/languages_list.dart';
import 'package:control/navigation/navigator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChangeListItemView extends StatefulWidget {
  const ChangeListItemView({
    Key? key,
    required this.language,
    required this.onSelectLanguage,
  }) : super(key: key);

  final Language language;
  final Function(Language) onSelectLanguage;

  @override
  State<ChangeListItemView> createState() => ChangeListItemViewState();
}

class ChangeListItemViewState extends State<ChangeListItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.eight),
      child: GestureDetector(
        onTap: () async {
          FiicoLocale.locale = widget.language.locale;
          await context.setLocale(FiicoLocale.locale);
          widget.onSelectLanguage(widget.language);
          FiicoRoute.back(context);
        },
        child: Container(
          color: FiicoColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _iconFlagView(),
              _nameSettingItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameSettingItem() {
    return Text(
      widget.language.name,
      style: Style.subtitle.copyWith(
        fontSize: FiicoFontSize.xs,
        color: FiicoColors.grayNeutral,
      ),
    );
  }

  Widget _iconFlagView() {
    return Container(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.twenyFour,
        left: FiicoPaddings.eight,
      ),
      child: FlagIcon(
        widget.language.flag,
        size: 40,
      ),
    );
  }
}
