import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/home/model/home_filters_movements.dart';
import 'package:flutter/material.dart';

class HomeEmptyWithFilterView extends StatefulWidget {
  const HomeEmptyWithFilterView({
    Key? key,
    this.onTapNewItem,
    required this.indexFilter,
  }) : super(key: key);

  final VoidCallback? onTapNewItem;
  final int indexFilter;

  @override
  State<HomeEmptyWithFilterView> createState() =>
      HomeEmptyWithFilterViewState();
}

class HomeEmptyWithFilterViewState extends State<HomeEmptyWithFilterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FiicoColors.white,
      padding: const EdgeInsets.only(top: FiicoPaddings.sixtyTwo),
      alignment: Alignment.center,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        children: [
          _emptyText(),
          _bodyButton(),
        ],
      ),
    );
  }

  Widget _emptyText() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Text(
        "${FiicoLocale().youHaveNot} ${HomeFilterMovement().itemsFilter[widget.indexFilter]} ${FiicoLocale().forNow}!",
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _bodyButton() {
    return FiicoButton.pink(
      ontap: () => widget.onTapNewItem!.call(),
      title: ' ${FiicoLocale().addMovement} ',
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
    );
  }
}
