import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/entryDetail/view/detail/header/entry_detail_item_header.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EntryDetailSuccessView extends StatelessWidget {
  const EntryDetailSuccessView({
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
      child: EntryDetailHeaderView(
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
        bottom: 24,
        top: 8,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              movement.value.toCurrency(),
              style: Style.subtitle.copyWith(
                color: FiicoColors.greenNeutral,
                fontSize: FiicoFontSize.lg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            movement.currency,
            style: Style.subtitle.copyWith(
              color: FiicoColors.greenNeutral,
              fontSize: FiicoFontSize.sm,
            ),
          )
        ],
      ),
    );
  }

  Widget _infoDateDetailView() {
    return Row(
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
              "Cada mes",
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xm,
              ),
            )
          ],
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
