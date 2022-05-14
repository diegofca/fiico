import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/material.dart';

class CreateBottomView {
  final _textController = TextEditingController();

  void show(
    BuildContext context, {
    required Function(String) callbackName,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 0),
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
                    _title(),
                    _entryNameView(),
                    _createButtonView(context, callbackName),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _title() {
    return Text(
      FiicoLocale.createNewBudget,
      style: Style.title.copyWith(
        color: FiicoColors.black,
      ),
    );
  }

  Widget _entryNameView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              FiicoLocale.name,
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.md,
              ),
            ),
          ),
          BorderContainer(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FiicoTextfield(
                textEditingController: _textController,
                hintText: FiicoLocale.enterBudgetName,
                textColor: FiicoColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createButtonView(
      BuildContext context, Function(String) callbackName) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.sixteen,
        horizontal: FiicoPaddings.fourtySix,
      ),
      child: FiicoButton.pink(
        title: FiicoLocale.createBudget,
        ontap: () {
          Navigator.of(context).pop();
          if (_textController.text.isNotEmpty) {
            final text = _textController.text;
            callbackName(text);
          }
        },
      ),
    );
  }
}
