import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/models/movement.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateMovementHeaderView extends StatefulWidget {
  const CreateMovementHeaderView({
    Key? key,
    required this.type,
  }) : super(key: key);

  final MovementType type;

  @override
  State<CreateMovementHeaderView> createState() =>
      CreateMovementHeaderViewState();
}

class CreateMovementHeaderViewState extends State<CreateMovementHeaderView> {
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
        child: widget.type == MovementType.ENTRY
            ? const FiicoImageNetwork.entry()
            : const FiicoImageNetwork.debt(),
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
