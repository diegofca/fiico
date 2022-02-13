import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/view/debt_detail_page.dart';
import 'package:control/modules/entryDetail/view/detail/entry_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
      onTap: () => _onDetailViewed(),
      child: Container(
        color: Colors.white,
        height: 100,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _icon(),
            _nameAndDateView(),
            _priceAndDescView(),
          ],
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
        left: FiicoPaddings.twenyFour,
      ),
      child: Container(
        width: 75,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FiicoPaddings.eight),
          color: FiicoColors.grayLite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FiicoPaddings.sixteen),
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
        widget.movement.createdAt?.toDate().toDateFormat1() ?? '',
        style: Style.subtitle.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _priceAndDescView() {
    return Padding(
      padding: const EdgeInsets.only(right: FiicoPaddings.twenyFour),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _priceView(),
          _descriptionView(),
        ],
      ),
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: DefaultTextStyle(
        style: TextStyle(
          color: widget.movement.getTypeColor(),
          fontWeight: FontWeight.bold,
          fontSize: FiicoFontSize.xs,
        ),
        child: SizedBox(
          height: 20,
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FadeAnimatedText(
                widget.movement.value?.toCurrency() ?? '',
                duration: const Duration(seconds: 3),
                fadeOutBegin: 0.8,
                fadeInEnd: 0.2,
              ),
              FadeAnimatedText(
                widget.movement.value?.toCurrencyCompat() ?? '',
                duration: const Duration(seconds: 3),
                fadeOutBegin: 0.8,
                fadeInEnd: 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.four),
      child: Text(
        widget.movement.typeDescription ?? '',
        style: Style.desc.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  void _onDetailViewed() {
    switch (widget.movement.getType()) {
      case MovementType.ENTRY:
        FiicoRoute.send(context, EntryDetailPage(movement: widget.movement));
        break;
      case MovementType.DEBT:
        FiicoRoute.send(context, DebtDetailPage(movement: widget.movement));
        break;
      default:
    }
  }
}
