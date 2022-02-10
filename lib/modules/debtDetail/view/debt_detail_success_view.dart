import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
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

  final Movement movement;

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
        movement.description,
        style: Style.subtitle.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _separatorLineView() {
    return Container(
      color: FiicoColors.grayLite,
      height: 1,
    );
  }

  Widget _pricesDetailView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _priceView(),
        _infoDateDetailView(),
      ],
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.twenyFour,
        top: FiicoPaddings.twenyFour,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              movement.value.toCurrency(),
              style: Style.subtitle.copyWith(
                color: FiicoColors.pinkRed,
                fontSize: FiicoFontSize.xl,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            movement.currency,
            style: Style.subtitle.copyWith(
              color: FiicoColors.pinkRed,
              fontSize: FiicoFontSize.sm,
            ),
          )
        ],
      ),
    );
  }

  Widget _infoDateDetailView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: FiicoPaddings.sixtyTwo,
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: FiicoPaddings.eight,
                  ),
                  child: Icon(MdiIcons.calendarCheck),
                ),
                Text(
                  "Cada mes",
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.graySoft,
                    fontSize: FiicoFontSize.xm,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: FiicoPaddings.thirtyTwo,
                  right: FiicoPaddings.eight,
                ),
                child: Icon(MdiIcons.clockOutline),
              ),
              Text(
                "Siempre",
                style: Style.subtitle.copyWith(
                  color: FiicoColors.graySoft,
                  fontSize: FiicoFontSize.xm,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _categoriesList() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: FiicoTagsView(
        tags: movement.tags.map((s) => s as String).toList(),
        onDeleteTag: (int index) {
          print(index);
        },
      ),
    );
  }
}
