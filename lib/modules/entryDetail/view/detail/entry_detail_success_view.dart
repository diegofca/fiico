import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/modules/entryDetail/view/detail/header/entry_detail_item_header.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EntryDetailSuccessView extends StatelessWidget {
  const EntryDetailSuccessView({
    Key? key,
  }) : super(key: key);

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
      child: const EntryDetailHeaderView(),
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
        "Salario principal de la panaderia de la calle 125 con av boyaca",
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: FiicoPaddings.sixteen),
                child: Row(
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
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: FiicoPaddings.eight),
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
          Row(
            children: [
              Text(
                "\$ 540.000",
                style: Style.subtitle.copyWith(
                  color: FiicoColors.greenNeutral,
                  fontSize: FiicoFontSize.lg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " cop",
                style: Style.subtitle.copyWith(
                  color: FiicoColors.greenNeutral,
                  fontSize: FiicoFontSize.sm,
                ),
              )
            ],
          ),
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
        tags: const ["UX", "Wireframe", "Design System", "Four"],
        onDeleteTag: (int index) {
          print(index);
        },
      ),
    );
  }
}
