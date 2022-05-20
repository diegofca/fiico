import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/view/debt_detail_page.dart';
import 'package:control/modules/entryDetail/view/detail/entry_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class MovementListItemView extends StatefulWidget {
  const MovementListItemView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement? movement;
  final Budget? budget;

  @override
  State<MovementListItemView> createState() => MovementListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class MovementListItemViewState extends State<MovementListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailMovement(context),
      child: Container(
        height: 80,
        width: double.maxFinite,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
        top: FiicoPaddings.eight,
        bottom: FiicoPaddings.eight,
        right: FiicoPaddings.eight,
        left: FiicoPaddings.eight,
      ),
      child: Container(
        width: 65,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
          color: FiicoColors.grayLite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FiicoPaddings.eight),
          child: FiicoImageNetwork.budget(
            iconData: widget.movement?.icon?.getIcon(),
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
        '${widget.movement?.name} -  ${widget.movement?.getTypeDescription()}',
        overflow: TextOverflow.ellipsis,
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.xm,
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
              color: widget.movement?.getPaymentStatusColor(),
              size: FiicoFontSize.xxs,
            ),
          ),
          Text(
            widget.movement?.getPaymentStatusText() ?? '',
            style: Style.subtitle.copyWith(
              color: widget.movement?.getPaymentStatusColor(),
              fontSize: FiicoFontSize.xs,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailMovement(BuildContext context) {
    switch (widget.movement?.getType()) {
      case MovementType.DEBT:
        FiicoRoute.send(
          context,
          DebtDetailPage(movement: widget.movement, budget: widget.budget),
        );
        break;
      case MovementType.ENTRY:
        FiicoRoute.send(
          context,
          EntryDetailPage(movement: widget.movement, budget: widget.budget),
        );
        break;
      default:
    }
  }
}
