import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateItemHeaderView extends StatefulWidget {
  const CreateItemHeaderView({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateItemHeaderView> createState() => CreateItemHeaderViewState();
}

class CreateItemHeaderViewState extends State<CreateItemHeaderView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconItem(),
          _bodyView(),
        ],
      ),
    );
  }

  Widget _iconItem() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
        right: FiicoPaddings.twenyFour,
        left: FiicoPaddings.twenyFour,
      ),
      child: Container(
        width: 75,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FiicoPaddings.eight),
          color: FiicoColors.grayLite,
        ),
        child: const FiicoImageNetwork.movement(),
      ),
    );
  }

  Widget _bodyView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameItemView(),
          _dateView(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return Text(
      "Danu",
      style: Style.title.copyWith(
        color: FiicoColors.grayDark,
        fontSize: FiicoFontSize.sm,
      ),
    );
  }

  Widget _dateView() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: FiicoPaddings.eight),
              child: Icon(
                MdiIcons.calendar,
                color: FiicoColors.black,
                size: 20,
              ),
            ),
            Text(
              'Abril 20',
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
