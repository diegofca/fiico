import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/bottom_afirmative_dialog.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/view/debt_detail_page.dart';
import 'package:control/modules/entryDetail/view/detail/entry_detail_page.dart';
import 'package:control/modules/home/bloc/home_bloc.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HomeListItemView extends StatefulWidget {
  const HomeListItemView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement? movement;

  @override
  State<HomeListItemView> createState() => HomeListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeListItemViewState extends State<HomeListItemView> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context
            .read<HomeBloc>()
            .add(HomeBudgetRemovedMovement(movement: widget.movement));
      },
      confirmDismiss: (direction) async {
        return BottomDialog().show(
          context,
          title:
              '¿Deseas eliminar ${widget.movement?.name} de ${widget.movement?.budgetName}?',
          titleButton: 'Eliminar',
          onTapAction: () {
            Navigator.pop(context, true);
          },
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          color: FiicoColors.grayLite,
        ),
        padding: const EdgeInsets.only(right: FiicoPaddings.sixteen),
        child: const Icon(
          MdiIcons.delete,
          color: FiicoColors.pinkRed,
        ),
      ),
      child: GestureDetector(
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
        child: widget.movement?.getIcon(),
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
        widget.movement?.name ?? '',
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
        widget.movement?.recurrencyAt?.toDate().toDateFormat1() ?? '',
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
          color: widget.movement?.getTypeColor(),
          fontWeight: FontWeight.bold,
          fontSize: FiicoFontSize.xs,
        ),
        child: SizedBox(
          height: 20,
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FadeAnimatedText(
                widget.movement?.getValue()?.toCurrency() ?? '',
                duration: const Duration(seconds: 3),
                fadeOutBegin: 0.8,
                fadeInEnd: 0.2,
              ),
              FadeAnimatedText(
                widget.movement?.getValue()?.toCurrencyCompat() ?? '',
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
        widget.movement?.typeDescription ?? '',
        style: Style.desc.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  void _onDetailViewed() {
    switch (widget.movement?.getType()) {
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
