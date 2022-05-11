import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/models/movement.dart';
import 'package:flutter/material.dart';

class DefaultMovementListItemView extends StatefulWidget {
  const DefaultMovementListItemView({
    Key? key,
    required this.movement,
    required this.onSelected,
  }) : super(key: key);

  final Movement movement;
  final Function(Movement) onSelected;

  @override
  State<DefaultMovementListItemView> createState() =>
      DefaultMovementListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class DefaultMovementListItemViewState
    extends State<DefaultMovementListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelected.call(
        widget.movement,
      ),
      child: Container(
        height: 70,
        color: FiicoColors.white,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconView(),
            _nameStatusView(),
          ],
        ),
      ),
    );
  }

  Widget _iconView() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.twenyFour,
        left: FiicoPaddings.twenyFour,
      ),
      child: Container(
        width: 75,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
          color: FiicoColors.grayLite,
        ),
        child: Center(
          child: FiicoImageNetwork(
            iconData: widget.movement.icon?.getIcon(),
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _nameStatusView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameView(),
          _statusView(),
        ],
      ),
    );
  }

  Widget _nameView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.movement.name ?? '',
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _statusView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.eight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              color: widget.movement.getTypeColor(),
              size: 12,
            ),
          ),
          Text(
            widget.movement.type ?? '',
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xm,
            ),
          ),
        ],
      ),
    );
  }
}
