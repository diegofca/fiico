import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/bloc/send_suggestion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendSuggestionSuccessView extends StatelessWidget {
  SendSuggestionSuccessView({
    Key? key,
  }) : super(key: key);

  final TextEditingController _controller = FiicoEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: const GenericAppBar(bottomHeigth: FiicoPaddings.zero),
      body: Container(
        height: double.maxFinite,
        color: FiicoColors.grayBackground,
        padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
        child: _bodyView(context),
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: FiicoColors.grayLite,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.centerShadow],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: FiicoPaddings.twenyFour,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.twenyFour,
          ),
          child: _inputsListView(context),
        ),
      ),
    );
  }

  Widget _inputsListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _iHaveSuggestionTextView(context),
        _pleaseTellMore(context),
        _textAreaView(context),
        _minimumCharactersInText(),
        _sendSuggestionView(context),
      ],
    );
  }

  Widget _iHaveSuggestionTextView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
      child: Text(
        FiicoLocale().iHaveSuggestion,
        maxLines: FiicoMaxLines.two,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.lg,
        ),
      ),
    );
  }

  Widget _pleaseTellMore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.twenyFour),
      child: Text(
        FiicoLocale().pleaseTellUsMore,
        maxLines: FiicoMaxLines.two,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _textAreaView(BuildContext context) {
    _controller.text = context.read<SendSuggestionBloc>().state.text ?? '';
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(FiicoPaddings.sixteen),
        decoration: BoxDecoration(
          border: Border.all(
            color: FiicoColors.pink,
          ),
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        ),
        child: TextField(
          maxLines: FiicoMaxLines.ten,
          controller: _controller,
          onChanged: (newText) => context
              .read<SendSuggestionBloc>()
              .add(SendSuggestionUpdateTexRequest(text: newText)),
          decoration: InputDecoration.collapsed(
            hintText: FiicoLocale().weLoveToKnowFeatureLooking,
            hintStyle: Style.subtitle.copyWith(
              color: FiicoColors.grayNeutral,
              fontSize: FiicoFontSize.xm,
            ),
          ),
          cursorColor: FiicoColors.pink,
          style: Style.subtitle.copyWith(
            color: FiicoColors.grayDark,
            fontSize: FiicoFontSize.xm,
          ),
        ),
      ),
    );
  }

  Widget _minimumCharactersInText() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: Text(
        FiicoLocale().youMustAddMinimumCharacters,
        maxLines: FiicoMaxLines.two,
        textAlign: TextAlign.left,
        style: Style.subtitle.copyWith(
          color: isSendSuggestionAvailable()
              ? FiicoColors.pink
              : FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _sendSuggestionView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(FiicoPaddings.eight),
      width: double.maxFinite,
      child: FiicoButton(
        title: FiicoLocale().sendSuggestion,
        color: isSendSuggestionAvailable()
            ? FiicoColors.pink
            : FiicoColors.graySoft,
        onTap: () {
          if (isSendSuggestionAvailable()) {
            _controller.clear();
            context
                .read<SendSuggestionBloc>()
                .add(const SendSuggetionRequest());
          }
        },
      ),
    );
  }

  bool isSendSuggestionAvailable() {
    return _controller.text.length > 15 && _controller.text.length < 300;
  }
}
