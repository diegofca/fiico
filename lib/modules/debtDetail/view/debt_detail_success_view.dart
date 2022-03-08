import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/view/headerView/debt_detail_header_view.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DebtDetailSuccessView extends StatelessWidget {
  const DebtDetailSuccessView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement? movement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _headerView(),
          _bodyView(),
        ],
      ),
    );
  }

  Widget _headerView() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 110,
      decoration: BoxDecoration(
        color: FiicoColors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: DebtDetailHeaderView(
        movement: movement,
      ),
    );
  }

  Widget _bodyView() {
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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.twenyFour,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _descriptionView(),
                _separatorLineView(),
                _pricesDetailView(),
                _separatorLineView(),
                _categoriesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.eight,
        vertical: FiicoPaddings.thirtyTwo,
      ),
      child: Text(
        movement?.description ?? '',
        maxLines: FiicoMaxLines.unlimited,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _separatorLineView() {
    return const SeparatorView();
  }

  Widget _pricesDetailView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _priceView(),
          _infoDateDetailView(),
        ],
      ),
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.thirtyTwo,
        top: FiicoPaddings.sixteen,
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: FiicoPaddings.eight),
              child: Text(
                movement?.value?.toCurrency() ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.pinkRed,
                  fontSize: FiicoFontSize.xl,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              movement?.currency ?? '',
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                color: FiicoColors.pinkRed,
                fontSize: FiicoFontSize.xs,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoDateDetailView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: FiicoPaddings.eight),
              child: Icon(MdiIcons.calendarCheck),
            ),
            Text(
              movement?.recurrency ?? '',
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.xm,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: FiicoPaddings.sixteen,
            right: FiicoPaddings.eight,
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: FiicoPaddings.eight,
                ),
                child: Icon(MdiIcons.clockOutline),
              ),
              Text(
                movement?.getRecurrencyDate() ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: FiicoMaxLines.four,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.grayNeutral,
                  fontSize: FiicoFontSize.xm,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _categoriesList() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: FiicoTagsView(
        tagBackgroundColor: FiicoColors.pink,
        tags: movement?.tags ?? [],
      ),
    );
  }
}
