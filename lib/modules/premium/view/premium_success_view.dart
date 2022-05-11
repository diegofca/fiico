import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/purchase_manager.dart';
import 'package:control/modules/premium/repository/premium_repository.dart';
import 'package:control/modules/premium/view/widgets/premium_items_purchase.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PremiumSuccessView extends StatelessWidget {
  const PremiumSuccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: _bodyView(context),
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Stack(
      children: [
        _purpleBgView(),
        _premiumDetailListView(context),
        _closeButton(context)
      ],
    );
  }

  Widget _purpleBgView() {
    return Image.asset(
      SVGImages.purpleBg,
      fit: BoxFit.cover,
      height: double.maxFinite,
      width: double.maxFinite,
    );
  }

  Widget _premiumDetailListView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _iconValiuView(),
          _premiumTitleText(),
          _premiumSubTitleText(),
          _centralImageView(),
          _benefictsTitleView(),
          _benefictsListView(),
          _dudesTitleView(),
          _dudesButtonView(),
          _cancelDescriptionView(),
          _payAndSafeTitleView(),
          _showPlansButtonView(context),
          _restoreShopsButton(),
          _politicsAndPrivacityButton(),
        ],
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FiicoRoute.back(context),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(FiicoPaddings.sixteen),
          alignment: Alignment.topRight,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(FiicoPaddings.eight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(
                MdiIcons.closeCircle,
                color: FiicoColors.purpleDark,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconValiuView() {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            const Positioned(
              top: FiicoPaddings.sixtyTwo,
              right: FiicoPaddings.sixteen,
              child: Icon(
                MdiIcons.crownOutline,
                color: FiicoColors.gold,
                size: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: FiicoPaddings.eigthTeen,
              ),
              child: SvgPicture.asset(
                SVGImages.valiuIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _premiumTitleText() {
    return Text(
      'Plan Premium',
      style: Style.subtitle.copyWith(
        color: FiicoColors.graySoft,
        fontSize: FiicoFontSize.lg,
      ),
    );
  }

  Widget _premiumSubTitleText() {
    return Padding(
      padding: const EdgeInsets.all(
        FiicoPaddings.thirtyTwo,
      ),
      child: Text(
        'Activa la cuenta premium y con ella podrás mejorar y agregar más presupuestos.',
        maxLines: FiicoMaxLines.ten,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.white.withOpacity(0.4),
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _centralImageView() {
    return SizedBox(
      height: 320,
      child: SvgPicture.asset(
        SVGImages.handDolarIcon,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _benefictsTitleView() {
    return Text(
      'Beneficios',
      style: Style.subtitle.copyWith(
        color: FiicoColors.white,
        fontSize: FiicoFontSize.xl,
      ),
    );
  }

  Widget _benefictsListView() {
    return ListView.builder(
      itemCount: PremiumRepository.benefics.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final benefic = PremiumRepository.benefics[index];
        return _beneficItemView(benefic);
      },
    );
  }

  Widget _beneficItemView(String benefic) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.twenyFour,
      ),
      child: Row(
        children: [
          const Icon(
            MdiIcons.star,
            color: FiicoColors.gold,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: FiicoPaddings.eight,
                left: FiicoPaddings.sixteen,
              ),
              child: Text(
                benefic,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.white,
                  fontSize: FiicoFontSize.xm,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dudesTitleView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Text(
        '¿Tienes dudas?',
        style: Style.subtitle.copyWith(
          color: FiicoColors.white.withOpacity(0.5),
          fontSize: FiicoFontSize.xl,
        ),
      ),
    );
  }

  Widget _dudesButtonView() {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.eigthTeen,
        vertical: FiicoPaddings.eight,
      ),
      width: double.maxFinite,
      child: FiicoButton(
        title: 'Contactanos',
        color: FiicoColors.white.withOpacity(0.2),
        textColor: FiicoColors.white.withOpacity(0.3),
        onTap: () {},
      ),
    );
  }

  Widget _cancelDescriptionView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.sixtyTwo,
      ),
      child: Text(
        'Tu puedes cancelar tu subscripción en el momento que quieras',
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.white.withOpacity(0.5),
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _payAndSafeTitleView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Text(
        'Ahorra hasta 56% con el Premium Ilimitado',
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.white,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _showPlansButtonView(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.thirtyTwo,
      ),
      width: double.maxFinite,
      child: FiicoButton(
        title: 'Ver planes',
        color: FiicoColors.white,
        textColor: FiicoColors.purpleNeutral,
        onTap: () async {
          final plans = PurchaseManager.get.getPlans();
          PremiumItemsPage().show(
            context,
            plans: plans,
            onPlanSelected: (plan) {
              PurchaseManager.get.purchase(context, plan);
            },
          );
        },
      ),
    );
  }

  Widget _restoreShopsButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Text(
        'Restaurar compras',
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.white.withOpacity(0.5),
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _politicsAndPrivacityButton() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: FiicoPaddings.sixteen,
          top: FiicoPaddings.eight,
        ),
        child: Text(
          'Politica de privadad y Terminos de uso',
          maxLines: FiicoMaxLines.four,
          textAlign: TextAlign.center,
          style: Style.subtitle.copyWith(
            color: FiicoColors.white.withOpacity(0.3),
            fontSize: FiicoFontSize.xs,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
