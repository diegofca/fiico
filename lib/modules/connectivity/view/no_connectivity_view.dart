import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/connectivity/bloc%20/connectivity_bloc.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoConnectivityPage extends StatelessWidget {
  const NoConnectivityPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().withOutConnection,
        textColor: FiicoColors.black,
        isShowBack: false,
      ),
      body: const NoConnectivityView(),
    );
  }
}

class NoConnectivityView extends StatelessWidget {
  const NoConnectivityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FiicoRoute.hideLoader(context);
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _bodyView(context),
    );
  }

  Widget _bodyView(BuildContext context) {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _notConnectionAnimationView(),
          _notConnectionText(),
          _reloadIntent(context)
        ],
      ),
    );
  }

  Widget _notConnectionAnimationView() {
    return Image.asset(
      GIFmages.lostConnection,
      gaplessPlayback: false,
    );
  }

  Widget _notConnectionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      child: Text(
        FiicoLocale().pleaseCheckYourInternet,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xm,
        ),
        textAlign: TextAlign.center,
        maxLines: FiicoMaxLines.ten,
      ),
    );
  }

  Widget _reloadIntent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: FiicoButton(
        title: 'Reload',
        color: FiicoColors.pink,
        onTap: () => context
            .read<ConnectivityBloc>()
            .add(const ConnectivityCheckRequested()),
      ),
    );
  }
}
