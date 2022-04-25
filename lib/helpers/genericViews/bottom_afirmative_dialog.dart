import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:flutter/material.dart';

class BottomDialog {
  Future<bool?> show(
    BuildContext context, {
    String? title = '',
    String? titleButton = '',
    required Function() onTapAction,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: EdgeInsets.only(
                left: FiicoPaddings.thirtyTwo,
                right: FiicoPaddings.thirtyTwo,
                top: FiicoPaddings.thirtyTwo,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(FiicoPaddings.twenyFour),
                  topRight: Radius.circular(FiicoPaddings.twenyFour),
                ),
              ),
              child: SafeArea(
                child: Wrap(
                  children: [
                    _title(title),
                    _createButtonView(context, titleButton, onTapAction),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _title(String? title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.eight,
      ),
      child: Text(
        title ?? '',
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.center,
        style: Style.desc.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.md,
        ),
      ),
    );
  }

  Widget _createButtonView(
      BuildContext context, String? titleButton, Function() onTapAction) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.sixteen,
        horizontal: FiicoPaddings.fourtySix,
      ),
      child: FiicoButton.pink(
        title: titleButton ?? '',
        ontap: () => onTapAction(),
      ),
    );
  }
}
