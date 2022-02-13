import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/movement.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EntryDetailHeaderView extends StatefulWidget {
  const EntryDetailHeaderView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  State<EntryDetailHeaderView> createState() => EntryDetailHeaderViewState();

  Size get preferredSize => throw UnimplementedError();
}

class EntryDetailHeaderViewState extends State<EntryDetailHeaderView> {
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
        child: widget.movement.getIcon(),
      ),
    );
  }

  Widget _bodyView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _nameItemView(),
              _bellIconView(),
            ],
          ),
          _statusAndDate(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return SizedBox(
      width: 190,
      child: Text(
        widget.movement.name ?? '',
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _bellIconView() {
    return GestureDetector(
      onTap: () {
        print("bell click");
      },
      child: const Padding(
        padding: EdgeInsets.only(
          right: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.eight,
        ),
        child: Icon(
          MdiIcons.bell,
          color: FiicoColors.gold,
          size: 20,
        ),
      ),
    );
  }

  Widget _statusAndDate() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              color: FiicoColors.gold,
              size: 12,
            ),
          ),
          Text(
            "Pendiente: ${widget.movement.createdAt?.toDate().toDateFormat1()}",
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xs,
            ),
          ),
        ],
      ),
    );
  }
}
