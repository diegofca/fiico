import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/createBudget/bloc/create_budget_bloc.dart';
import 'package:control/modules/createBudget/view/widgets/create_budget_cycle_selector_view.dart';
import 'package:control/modules/createBudget/view/widgets/create_budget_duration_selector_view.dart';
import 'package:control/modules/createMovement/view/widgets/create_movement_date_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBudgetCycleView extends StatelessWidget {
  const CreateBudgetCycleView({
    Key? key,
    required this.budgetToCreate,
  }) : super(key: key);

  final Budget budgetToCreate;

  @override
  Widget build(BuildContext context) {
    return _entryDurationView(context);
  }

  Widget _entryDurationView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: FiicoPaddings.twenyFour,
          ),
          child: BorderContainer(
            alignment: Alignment.center,
            heigth: budgetToCreate.isCycle ?? true ? 250 : 430,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _isRepetitiveSwitchView(context),
                  const SeparatorView(),
                  _cycleSelectorView(context),
                  _durationSelectorView(context),
                  _initalDateSelectorView(context),
                  _endDateSelectedView(context),
                  _infoDetailView(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _isRepetitiveSwitchView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: FiicoPaddings.sixteen,
        right: FiicoPaddings.eight,
        bottom: FiicoPaddings.eight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Repetitivo',
                textAlign: TextAlign.left,
                maxLines: FiicoMaxLines.ten,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.grayNeutral,
                  fontSize: FiicoFontSize.sm,
                ),
              ),
            ),
          ),
          Switch.adaptive(
            value: budgetToCreate.isCycle ?? true,
            activeColor: FiicoColors.pink,
            onChanged: (isCycle) {
              context
                  .read<CreateBudgetBloc>()
                  .add(CreateBudgetInfoSelected(isCycle: isCycle));
            },
          ),
        ],
      ),
    );
  }

  Widget _cycleSelectorView(BuildContext context) {
    return Visibility(
      visible: budgetToCreate.isCycle ?? true,
      child: Padding(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
          right: FiicoPaddings.sixteen,
          top: FiicoPaddings.eight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.sixteen,
              ),
              child: Text(
                'Repetir',
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: FiicoPaddings.eight,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        budgetToCreate.getCycleText(),
                        textAlign: TextAlign.left,
                        style: Style.subtitle.copyWith(
                          color: FiicoColors.grayNeutral,
                          fontSize: FiicoFontSize.sm,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => CreateBudgetCycleSelectorView().show(
                      context,
                      onDurationSelected: (cycle) {
                        context
                            .read<CreateBudgetBloc>()
                            .add(CreateBudgetInfoSelected(cycle: cycle.value));
                      },
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: FiicoColors.pink,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
            const SeparatorView(),
          ],
        ),
      ),
    );
  }

  Widget _durationSelectorView(BuildContext context) {
    return Visibility(
      visible: !(budgetToCreate.isCycle ?? true),
      child: Padding(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
          right: FiicoPaddings.sixteen,
          top: FiicoPaddings.eight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.eight,
              ),
              child: Text(
                'Duración',
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: FiicoPaddings.eight,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        budgetToCreate.getDurationText(),
                        textAlign: TextAlign.left,
                        style: Style.subtitle.copyWith(
                          color: FiicoColors.grayNeutral,
                          fontSize: FiicoFontSize.sm,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => CreateBudgetDurationSelectorView().show(
                      context,
                      onDurationSelected: (duration) {
                        context.read<CreateBudgetBloc>().add(
                            CreateBudgetInfoSelected(duration: duration.value));
                      },
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: FiicoColors.pink,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
            const SeparatorView(),
          ],
        ),
      ),
    );
  }

  Widget _initalDateSelectorView(BuildContext context) {
    return Visibility(
      visible: !(budgetToCreate.isCycle ?? true),
      child: Padding(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
          right: FiicoPaddings.sixteen,
          top: FiicoPaddings.eight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.eight,
              ),
              child: Text(
                'Fecha de inicio',
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: FiicoPaddings.eight,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        budgetToCreate.startDate?.toDate().toDateFormat2() ??
                            '',
                        textAlign: TextAlign.left,
                        style: Style.subtitle.copyWith(
                          color: FiicoColors.grayNeutral,
                          fontSize: FiicoFontSize.sm,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => CreateMovementDateSelectorView().show(
                      context,
                      initalDate: budgetToCreate.startDate?.toDate(),
                      onDateSelected: (date) {
                        final initDate = Timestamp.fromDate(date);
                        context
                            .read<CreateBudgetBloc>()
                            .add(CreateBudgetInfoSelected(initDate: initDate));

                        final finishDate = budgetToCreate.getFinishDate();
                        context.read<CreateBudgetBloc>().add(
                            CreateBudgetInfoSelected(finishDate: finishDate));
                      },
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: FiicoColors.pink,
                      size: 34,
                    ),
                  ),
                ],
              ),
            ),
            const SeparatorView(),
          ],
        ),
      ),
    );
  }

  Widget _endDateSelectedView(BuildContext context) {
    return Visibility(
      visible: !(budgetToCreate.isCycle ?? true),
      child: Padding(
        padding: const EdgeInsets.only(
          left: FiicoPaddings.sixteen,
          right: FiicoPaddings.sixteen,
          top: FiicoPaddings.eight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.sixteen,
              ),
              child: Text(
                'Fecha final',
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: FiicoPaddings.eight,
                        bottom: FiicoPaddings.sixteen,
                        top: FiicoPaddings.eight,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        budgetToCreate.getFinishDate().toDate().toDateFormat2(),
                        textAlign: TextAlign.left,
                        style: Style.subtitle.copyWith(
                          color: FiicoColors.grayNeutral,
                          fontSize: FiicoFontSize.sm,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: budgetToCreate.isCustomDuration(),
                    child: IconButton(
                      onPressed: () => CreateMovementDateSelectorView().show(
                        context,
                        initalDate: budgetToCreate.getFinishDate().toDate(),
                        onDateSelected: (date) {
                          final finishDate = Timestamp.fromDate(date);
                          context.read<CreateBudgetBloc>().add(
                              CreateBudgetInfoSelected(finishDate: finishDate));
                        },
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: FiicoColors.pink,
                        size: 34,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SeparatorView(),
          ],
        ),
      ),
    );
  }

  Widget _infoDetailView() {
    return Container(
      padding: const EdgeInsets.all(
        FiicoPaddings.sixteen,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        budgetToCreate.getCycleDescription(),
        textAlign: TextAlign.left,
        maxLines: FiicoMaxLines.ten,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }
}
