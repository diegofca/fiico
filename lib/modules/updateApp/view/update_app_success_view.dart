// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/cupertino.dart';

class UpdateAppSuccessView extends StatelessWidget {
  const UpdateAppSuccessView({
    Key? key,
    required this.onCancelAction,
    required this.onUpdateAction,
    required this.forceUpdate,
  }) : super(key: key);

  final Function onCancelAction;
  final Function onUpdateAction;
  final bool forceUpdate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _titleView(context),
          _subtitleView(context),
          _buttonsView(),
        ],
      ),
    );
  }

  Widget _titleView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
      ),
      child: Text(
        forceUpdate
            ? FiicoLocale().newUpdateRequiered
            : FiicoLocale().newUpdate,
        style: Style.title,
      ),
    );
  }

  Widget _subtitleView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.thirtyTwo,
        left: FiicoPaddings.sixteen,
        right: FiicoPaddings.sixteen,
      ),
      child: Text(
        FiicoLocale().updateDescription,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xm,
        ),
        maxLines: FiicoMaxLines.ten,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buttonsView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: !forceUpdate,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: FiicoPaddings.sixteen),
            child: FiicoButton(
              title: FiicoLocale().after,
              color: FiicoColors.white,
              borderColor: FiicoColors.purpleDark,
              textColor: FiicoColors.purpleDark,
              onTap: () => onCancelAction.call(),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: FiicoPaddings.sixteen),
          child: FiicoButton(
            title: FiicoLocale().update,
            color: FiicoColors.gold,
            onTap: () => onUpdateAction.call(),
          ),
        ),
      ],
    );
  }
}
