import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/string.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/view/debt_detail_page.dart';
import 'package:control/modules/entryDetail/view/detail/entry_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BudgetDetailMovementListItemView extends StatefulWidget {
  const BudgetDetailMovementListItemView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement movement;
  final Budget budget;

  @override
  State<BudgetDetailMovementListItemView> createState() =>
      BudgetDetailMovementListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class BudgetDetailMovementListItemViewState
    extends State<BudgetDetailMovementListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDetailViewed(),
      child: Container(
        color: FiicoColors.white,
        height: 90,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _markPaymentStatus(),
            _icon(),
            _nameAndDateView(),
            _priceAndDescView(),
          ],
        ),
      ),
    );
  }

  Widget _markPaymentStatus() {
    return Container(
      width: 5,
      margin: const EdgeInsets.only(
        top: FiicoPaddings.twelve,
        right: FiicoPaddings.eight,
        bottom: FiicoPaddings.sixteen,
      ),
      decoration: BoxDecoration(
        color: widget.movement.getPaymentStatusColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(FiicoPaddings.four),
        ),
      ),
    );
  }

  Widget _icon() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
        right: FiicoPaddings.sixteen,
      ),
      child: Container(
        width: 60,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FiicoPaddings.eight),
          color: FiicoColors.grayLite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FiicoPaddings.four),
          child: widget.movement.getIcon(),
        ),
      ),
    );
  }

  Widget _nameAndDateView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameView(),
          _dateView(),
        ],
      ),
    );
  }

  Widget _nameView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.movement.name ?? '',
        maxLines: 1,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _dateView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.four),
      child: Text(
        widget.movement.createdAt?.toDate().toDateFormat5().capitalize() ?? '',
        style: Style.subtitle.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _priceAndDescView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _priceView(),
        _descriptionView(),
      ],
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.movement.getValue()?.toCurrencyCompat() ?? '',
        style: TextStyle(
          color: widget.movement.getTypeColor(),
          fontWeight: FontWeight.bold,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _descriptionView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.four),
      child: GestureDetector(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Visibility(
              visible: !widget.movement.isPaymentPendingState(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  SVGImages.checkMarkIcon,
                  color: widget.movement.getPaymentStatusColor(),
                  width: 12,
                ),
              ),
            ),
            Text(
              widget.movement.getPaymentStatusText(),
              style: Style.title.copyWith(
                color: widget.movement.getPaymentStatusColor(),
                fontSize: FiicoFontSize.xs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDetailViewed() {
    switch (widget.movement.getType()) {
      case MovementType.ENTRY:
        FiicoRoute.send(
            context,
            EntryDetailPage(
              movement: widget.movement,
              budget: widget.budget,
            ));
        break;
      case MovementType.DEBT:
      case MovementType.DAILY_DEBT:
        FiicoRoute.send(
            context,
            DebtDetailPage(
              movement: widget.movement,
              budget: widget.budget,
            ));
        break;
      default:
    }
  }
}
