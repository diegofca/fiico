import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/mark_movement.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/bloc/debt_detail_bloc.dart';
import 'package:control/modules/debtDetail/view/headerView/debt_detail_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DebtDetailSuccessView extends StatelessWidget {
  const DebtDetailSuccessView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement? movement;
  final Budget? budget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _headerView(),
          _bodyView(context),
        ],
      ),
    );
  }

  Widget _headerView() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 110,
      decoration: BoxDecoration(
        color: FiicoColors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: DebtDetailHeaderView(movement: movement, budget: budget),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: FiicoPaddings.fourtySix),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: [FiicoShadow.cardShadow],
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.twenyFour,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _descriptionView(),
                _separatorLineView(),
                _pricesDetailView(),
                _datesPaymentList(),
                _categoriesList(),
                _historyPaymentList(),
                _paymentButtonView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.eight,
        vertical: FiicoPaddings.thirtyTwo,
      ),
      child: Text(
        movement?.description ?? 'No hay descripción',
        maxLines: FiicoMaxLines.unlimited,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _separatorLineView() {
    return const SeparatorView();
  }

  Widget _pricesDetailView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _priceView(),
          _infoDateDetailView(),
        ],
      ),
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.thirtyTwo,
        top: FiicoPaddings.sixteen,
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: FiicoPaddings.eight),
              child: Text(
                movement?.value?.toCurrency() ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.pinkRed,
                  fontSize: FiicoFontSize.xl,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              movement?.currency ?? '',
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                color: FiicoColors.pinkRed,
                fontSize: FiicoFontSize.xs,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoDateDetailView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                right: FiicoPaddings.eight,
              ),
              child: Icon(MdiIcons.clockOutline),
            ),
            Expanded(
              child: Text(
                movement?.getRecurrencyDateDescription() ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: FiicoMaxLines.two,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.grayNeutral,
                  fontSize: FiicoFontSize.xm,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _categoriesList() {
    return Container(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
        bottom: FiicoPaddings.sixteen,
      ),
      child: FiicoTagsView(
        tagBackgroundColor: FiicoColors.pink,
        tags: movement?.tags ?? [],
      ),
    );
  }

  Widget _paymentButtonView(BuildContext context) {
    return Visibility(
      visible: movement?.isPaymentPendingState() ?? true,
      child: Column(
        children: [
          Text(
            FiicoLocale().rememberMarkOutcomeMovement,
            style: Style.subtitle.copyWith(
              color: FiicoColors.grayNeutral,
              fontSize: FiicoFontSize.xm,
            ),
            maxLines: FiicoMaxLines.unlimited,
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: FiicoPaddings.eight),
            child: FiicoButton(
              title: FiicoLocale().markAsPaid,
              color: FiicoColors.pinkRed,
              image: SVGImages.checkMarkIcon,
              onTap: () {
                context
                    .read<DebtDetailBloc>()
                    .add(DebtDetailMarkPayedMovement(movement: movement));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyPaymentList() {
    final items = movement?.markHistory ?? [];
    return Visibility(
      visible: items.isNotEmpty,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              'Pagos realizados:',
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.xm,
              ),
              maxLines: FiicoMaxLines.unlimited,
            ),
          ),
          SizedBox(
            height: (items.length * 25) + FiicoPaddings.twenyFour,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final historyItem = items[index];
                return _historyPaymentItem(historyItem);
              },
              itemCount: items.length,
              padding: const EdgeInsets.only(
                top: FiicoPaddings.twenyFour,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.twenyFour,
            ),
            child: _separatorLineView(),
          ),
        ],
      ),
    );
  }

  Widget _historyPaymentItem(MarkMovement? markMovement) {
    return SizedBox(
      height: 25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            MdiIcons.dotsHexagon,
            color: FiicoColors.pink,
          ),
          Padding(
            padding: const EdgeInsets.only(left: FiicoPaddings.eight),
            child: Text(
              markMovement?.date?.toDate().toDateFormat4() ?? '',
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: FiicoPaddings.eight),
              child: Text(
                'Payment by ${markMovement?.userName}',
                style: Style.subtitle.copyWith(
                  color: FiicoColors.grayNeutral,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datesPaymentList() {
    final items = movement?.recurrencyDates ?? [];
    return Visibility(
      visible: !(budget?.isCycleBudget() ?? false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: (items.length * 30),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final date = items[index];
                return _datesPaymentItem(date);
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _datesPaymentItem(Timestamp? date) {
    return SizedBox(
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            MdiIcons.dotsCircle,
            color: FiicoColors.pink,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: FiicoPaddings.sixteen),
            child: Text(
              date?.toDate().toDateFormat2() ?? '',
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
