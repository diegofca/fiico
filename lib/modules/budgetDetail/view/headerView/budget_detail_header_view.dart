import 'dart:async';

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/helpers/genericViews/fiico_selector_icon.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:flutter/material.dart';

class BudgetDetailHeaderView extends StatefulWidget {
  const BudgetDetailHeaderView({
    Key? key,
    required this.budget,
    required this.onNewIconSelected,
  }) : super(key: key);

  final Budget budget;
  final Function(FiicoIcon?) onNewIconSelected;

  @override
  State<BudgetDetailHeaderView> createState() => BudgetDetailHeaderViewState();
}

class BudgetDetailHeaderViewState extends State<BudgetDetailHeaderView> {
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
    return GestureDetector(
      onTap: () async {
        if (widget.budget.isReadAndWriteOnly) {
          final icon = await FiicoSelectorIcon.select(context);
          Timer(const Duration(milliseconds: 100), () {
            widget.onNewIconSelected(icon);
          });
        }
      },
      child: Padding(
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
          child: FiicoImageNetwork.budget(
            iconData: widget.budget.icon?.getIcon(),
          ),
        ),
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
            children: [_nameItemView()],
          ),
          _statusAndDate(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return Expanded(
      child: Text(
        widget.budget.name ?? '',
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
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
          Padding(
            padding: const EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              color: widget.budget.getStatusColor(),
              size: 12,
            ),
          ),
          Text(
            widget.budget.status ?? '',
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
