import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class BudgetListItemView extends StatefulWidget {
  const BudgetListItemView({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<BudgetListItemView> createState() => BudgetListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class BudgetListItemViewState extends State<BudgetListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // widget.items += 1;
          // _scrollDown();
          // context.read<MenuBloc>().add(MenuIndexSelected(index: 2));
        });
      },
      child: SizedBox(
        height: 100,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _iconView(),
            _nameStatusView(),
            _totalPriceView(),
          ],
        ),
      ),
    );
  }

  Widget _iconView() {
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
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
          color: FiicoColors.grayLite,
        ),
        child: const Icon(
          Icons.camera,
          size: 40,
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
        "Danu",
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
          const Padding(
            padding: EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              size: 12,
            ),
          ),
          Text(
            "Activo",
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalPriceView() {
    return Padding(
      padding: const EdgeInsets.only(right: FiicoPaddings.twenyFour),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
            child: Text(
              "Total",
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xm,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: FiicoPaddings.eight),
            child: Text(
              "\$45.33",
              style: TextStyle(
                color: FiicoColors.greenNeutral,
                fontWeight: FontWeight.bold,
                fontSize: FiicoFontSize.xs,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
