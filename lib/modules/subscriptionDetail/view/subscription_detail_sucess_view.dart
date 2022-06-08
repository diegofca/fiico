import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/premium/repository/premium_repository.dart';
import 'package:control/modules/premium/view/premium_page.dart';
import 'package:control/modules/subscriptionDetail/bloc/subscription_detail_bloc.dart';
import 'package:control/modules/subscriptionDetail/view/header/subscription_detail_header.dart';
import 'package:control/modules/webView/view/web_view_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SubscriptionDetailSuccessView extends StatelessWidget {
  SubscriptionDetailSuccessView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _headerView(context),
          _bodyView(context),
        ],
      ),
    );
  }

  Widget _headerView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 110,
      decoration: BoxDecoration(
        color: FiicoColors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: SubscriptionDetailHeaderView(user: user),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: FiicoPaddings.fourtySix),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: [FiicoShadow.cardShadow],
        ),
        child: Stack(
          children: [
            Image.asset(
              GIFmages.bumbles,
              fit: BoxFit.cover,
              color: FiicoColors.pink.withAlpha(60),
              height: 600,
              gaplessPlayback: true,
            ),
            SingleChildScrollView(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputsListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _crownImage(context),
        _expirateDate(),
        _pricePlanText(),
        _unlimitedPlanText(context),
        _separatorLineView(),
        _benefictsListView(),
        _bottomTextsDescription(context),
      ],
    );
  }

  Widget _crownImage(BuildContext context) {
    return Icon(
      user?.currentPlan?.getStatusIcon(),
      color: user?.currentPlan?.getStatusIconColor(),
      size: 100,
    );
  }

  Widget _expirateDate() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: Column(
        children: [
          Text(
            user?.currentPlan?.getFinisthDateTitle() ?? '',
            maxLines: FiicoMaxLines.two,
            style: Style.subtitle.copyWith(
              color: FiicoColors.grayDark,
              fontSize: FiicoFontSize.xs,
            ),
          ),
          Text(
            user?.currentPlan?.getFinisthDate() ?? '',
            maxLines: FiicoMaxLines.two,
            style: Style.subtitle.copyWith(
              color: FiicoColors.grayDark,
              fontSize: FiicoFontSize.xm,
              fontWeight: FiicoFontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pricePlanText() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.twenyFour,
        top: FiicoPaddings.sixteen,
      ),
      child: Visibility(
        visible: !(user?.isPremium() ?? false),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              FiicoLocale().asLowAs,
              maxLines: FiicoMaxLines.two,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.xm,
              ),
            ),
            Text(
              ' \$16,99 ',
              maxLines: FiicoMaxLines.two,
              style: Style.subtitle.copyWith(
                color: FiicoColors.purpleNeutral,
                fontSize: FiicoFontSize.lg,
                fontWeight: FiicoFontWeight.bold,
              ),
            ),
            Text(
              FiicoLocale().perMonth,
              maxLines: FiicoMaxLines.two,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.xm,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _unlimitedPlanText(BuildContext context) {
    return Visibility(
      visible: !(user?.isUnlimited() ?? false),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: FiicoPaddings.twenyFour,
        ),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  FiicoLocale().buyYourUnlimitedPlan,
                  maxLines: FiicoMaxLines.four,
                  textAlign: TextAlign.center,
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.grayNeutral,
                    fontSize: FiicoFontSize.xs,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '\$36,99',
                    maxLines: FiicoMaxLines.two,
                    style: Style.subtitle.copyWith(
                      color: FiicoColors.gold,
                      fontSize: FiicoFontSize.xl,
                      fontWeight: FiicoFontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
              child: FiicoButton(
                title: FiicoLocale().buy,
                color: FiicoColors.gold,
                onTap: () => _buyPremiumAction(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefictsListView() {
    return ListView.builder(
      itemCount: PremiumRepository().benefics.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
        bottom: FiicoPaddings.thirtyTwo,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final benefic = PremiumRepository().benefics[index];
        return _beneficItemView(benefic);
      },
    );
  }

  Widget _beneficItemView(String benefic) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const Icon(
            MdiIcons.star,
            color: FiicoColors.gold,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: FiicoPaddings.sixteen,
              ),
              child: Text(
                benefic,
                maxLines: FiicoMaxLines.two,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.grayDark,
                  fontSize: FiicoFontSize.xs,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomTextsDescription(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _termsAndConditions(context),
          _cancelTextConditions(),
        ],
      ),
    );
  }

  Widget _termsAndConditions(BuildContext context) {
    return GestureDetector(
      onTap: () => FiicoRoute.send(
        context,
        const WebviewPage(url: "www.google.com"),
      ),
      child: Padding(
        padding: const EdgeInsets.all(FiicoPaddings.eight),
        child: Text(
          FiicoLocale().termsAndConditionsOfUse,
          maxLines: FiicoMaxLines.two,
          textAlign: TextAlign.center,
          style: Style.subtitle.copyWith(
            color: FiicoColors.grayNeutral,
            fontSize: FiicoFontSize.xs,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _cancelTextConditions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        FiicoLocale().youCanCancelSubsAtAnyTime,
        maxLines: FiicoMaxLines.two,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xxs,
        ),
      ),
    );
  }

  Widget _separatorLineView() {
    return const SeparatorView();
  }

  void _buyPremiumAction(BuildContext context) {
    FiicoRoute.present(
      context,
      PremiumPage(
        user: user,
        showPlan: (plan) async {
          context
              .read<SubscriptionDetailBloc>()
              .add(UpdateSubscriptionDetail(newPlan: plan));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
