import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/deleteAccount/bloc/delete_account_bloc.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/model/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountPendingView extends StatelessWidget {
  const DeleteAccountPendingView({
    Key? key,
    required this.suggestion,
  }) : super(key: key);

  final Suggestion? suggestion;

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
        _iHavePendingTextView(context),
        _pleaseTellMore(context),
        _cancelTickButtonView(context)
      ],
    );
  }

  Widget _iHavePendingTextView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
      child: Text(
        'Tienes un ticket pendiente para \'Eliminación de cuenta\'.',
        maxLines: FiicoMaxLines.ten,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.md,
        ),
      ),
    );
  }

  Widget _pleaseTellMore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FiicoPaddings.twenyFour),
      child: Text(
        'Podrás cancelar el ticket antes de que un agente inicie el proceso.',
        maxLines: FiicoMaxLines.ten,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _cancelTickButtonView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(FiicoPaddings.eight),
      width: double.maxFinite,
      child: FiicoButton(
        title: FiicoLocale().cancelButton,
        color: FiicoColors.pink,
        onTap: () => {
          context
              .read<DeleteAccountBloc>()
              .add(CancelSuggestionRequest(suggestion: suggestion))
        },
      ),
    );
  }
}
