import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/view/debt_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class HomeListItemView extends StatefulWidget {
  const HomeListItemView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  State<HomeListItemView> createState() => HomeListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeListItemViewState extends State<HomeListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FiicoRoute.send(context, const DebtDetailPage()),
      child: Container(
        color: Colors.white,
        height: 100,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _icon(),
            _nameAndDateView(),
            _priceView(),
          ],
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
        widget.movement.name,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _dateView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.eight),
      child: Text(
        widget.movement.createAt.toDate().toString(),
        style: Style.subtitle.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _icon() {
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
        child: const Icon(
          Icons.camera,
          size: 40,
        ),
      ),
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(right: FiicoPaddings.twenyFour),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
            child: Text(
              widget.movement.value.toCurrency(),
              style: const TextStyle(
                color: FiicoColors.greenNeutral,
                fontWeight: FontWeight.bold,
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: FiicoPaddings.eight),
            child: Text(
              widget.movement.description,
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xm,
              ),
            ),
          )
        ],
      ),
    );
  }
}
