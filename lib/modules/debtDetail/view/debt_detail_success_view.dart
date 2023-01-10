import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_slide_action.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/debt_daily.dart';
import 'package:control/models/mark_movement.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/debtDetail/bloc/debt_detail_bloc.dart';
import 'package:control/modules/debtDetail/view/headerView/debt_detail_header_view.dart';
import 'package:control/modules/debtDetail/view/widget/debt_daily_bottom_view.dart';
import 'package:control/modules/debtDetail/view/widget/variable_valiu_bottom.dart';
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
                _debstDailyList(),
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
        movement?.description ?? FiicoLocale().noDescription,
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
        bottom: FiicoPaddings.sixteen,
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
    return Visibility(
      visible: movement?.tags?.isNotEmpty ?? false,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: FiicoPaddings.twenyFour,
        ),
        child: FiicoTagsView(
          tagBackgroundColor: FiicoColors.pink,
          tags: movement?.tags ?? [],
        ),
      ),
    );
  }

  Widget _paymentButtonView(BuildContext context) {
    return Visibility(
      visible: (movement?.isDailyDebtMovement() ?? false) ||
          (movement?.isPaymentPendingState() ?? true),
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
            child: _typePaymentButton(context),
          ),
        ],
      ),
    );
  }

  Widget _typePaymentButton(BuildContext context) {
    if (movement?.getType() == MovementType.DEBT) {
      return FiicoSlideButton(
        title: FiicoLocale().markAsPaid,
        color: FiicoColors.pinkRed,
        onSubmit: () => _paymentIntentAction(context),
        onStart: () => true,
      );
    }
    return FiicoButton(
      title: FiicoLocale().addNewExpense,
      color: FiicoColors.pinkRed,
      onTap: () => _paymentIntentAction(context),
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
              '${FiicoLocale().paymentsMade}:',
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
                '${FiicoLocale().paidBy} ${markMovement?.userName}',
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
      visible: !(budget?.isCycleBudget() ?? false) && items.length > 1,
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

  Widget _debstDailyList() {
    final items = movement?.debsDailyList ?? [];
    return Visibility(
      visible: movement?.isDailyDebtMovement() ?? false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _separatorLineView(),
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.sixteen,
              bottom: FiicoPaddings.sixteen,
            ),
            child: Text(
              FiicoLocale().dailyExpenses,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          Container(
            height: (items.length * 110),
            margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final debtDaily = items[index];
                return _debstDailyItem(debtDaily);
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _debstDailyItem(DebtDaily? debtDaily) {
    return SizedBox(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.donut_large,
                color: FiicoColors.pinkRed,
                size: FiicoFontSize.md,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: FiicoPaddings.eight,
                  right: FiicoPaddings.twenyFour,
                ),
                child: Text(
                  debtDaily?.name ?? '',
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.grayDark,
                    fontSize: FiicoFontSize.xm,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: FiicoPaddings.eight,
                  bottom: FiicoPaddings.eight,
                ),
                child: Text(
                  debtDaily?.value.toCurrency() ?? '',
                  style: Style.title.copyWith(
                    color: FiicoColors.pinkRed,
                    fontSize: FiicoFontSize.xm,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.eight,
              bottom: FiicoPaddings.eight,
            ),
            child: Text(
              '${FiicoLocale().addedBy} ${debtDaily?.userName}',
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: FiicoPaddings.sixteen,
            ),
            child: Text(
              debtDaily?.createdAt?.toDate().toDateFormat2() ?? '',
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
              ),
            ),
          ),
          _separatorLineView(),
        ],
      ),
    );
  }

  void _paymentIntentAction(BuildContext context) {
    switch (movement?.getType()) {
      case MovementType.DEBT:
        _markDebtPaymentIntent(context);
        break;
      case MovementType.DAILY_DEBT:
        _markDebtDailyPaymentIntent(context);
        break;
      default:
    }
  }

  void _markDebtPaymentIntent(BuildContext context) async {
    final bloc = context.read<DebtDetailBloc>();
    if (movement?.isVariableValue ?? false) {
      VariableValueBottoView().show(
        context,
        movement,
        callbackValue: (value) {
          bloc.add(DebtDetailMarkPayedMovement(
              movement: movement?.copyWith(value: value)));
        },
      );
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      bloc.add(DebtDetailMarkPayedMovement(movement: movement));
    }
  }

  void _markDebtDailyPaymentIntent(BuildContext context) {
    final bloc = context.read<DebtDetailBloc>();
    DebtDailyBottoView().show(
      context,
      movement,
      callbackValue: (newDebt) {
        bloc.add(DebtDetailAddDailyPayedMovement(
          movement: movement,
          value: newDebt,
        ));
      },
    );
  }
}
