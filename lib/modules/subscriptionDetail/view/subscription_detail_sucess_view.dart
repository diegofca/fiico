import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/premium/repository/premium_repository.dart';
import 'package:control/modules/subscriptionDetail/view/header/subscription_detail_header.dart';
import 'package:flutter/material.dart';
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
        _unlimitedPlanText(),
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
              'Por tan solo  ',
              maxLines: FiicoMaxLines.two,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.xm,
              ),
            ),
            Text(
              '\$29,99',
              maxLines: FiicoMaxLines.two,
              style: Style.subtitle.copyWith(
                color: FiicoColors.purpleNeutral,
                fontSize: FiicoFontSize.lg,
                fontWeight: FiicoFontWeight.bold,
              ),
            ),
            Text(
              ' mensuales',
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

  Widget _unlimitedPlanText() {
    return Visibility(
      visible: !(user?.isPremium() ?? false),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: FiicoPaddings.twenyFour,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              'O compra tu plan Ilimitado',
              maxLines: FiicoMaxLines.four,
              textAlign: TextAlign.center,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.xs,
              ),
            ),
            Text(
              ' y no tendrás que pagar una mensualidad para tener los mejores beneficios por tan solo...',
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
                '\$99,99',
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
          _termsAndConditions(),
          _cancelTextConditions(),
        ],
      ),
    );
  }

  Widget _termsAndConditions() {
    return GestureDetector(
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
}
