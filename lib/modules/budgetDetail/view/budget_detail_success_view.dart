import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/bottom_afirmative_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_profile_image.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/budgetDetail/ItemList/budget_detail_movement_list_item.dart';
import 'package:control/modules/budgetDetail/bloc/budget_detail_bloc.dart';
import 'package:control/modules/budgetDetail/view/headerView/budget_detail_header_view.dart';
import 'package:control/modules/budgetDetail/view/widgets/budget_circle_chart_history.dart';
import 'package:control/modules/budgetDetail/view/widgets/budget_detail_add_movement_view.dart';
import 'package:control/modules/budgetDetail/view/widgets/buget_linear_chart_history.dart';
import 'package:control/modules/createMovement/view/create_movement_page.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/view/default_movement_page.dart';
import 'package:control/modules/editMovement/view/edit_movement_page.dart';
import 'package:control/modules/movementList/view/movement_list_page.dart';
import 'package:control/modules/premium/view/premium_page.dart';
import 'package:control/modules/premiumUpdate/view/premium_update_page.dart';
import 'package:control/modules/searchUsers/view/search_users_page.dart';
import 'package:control/modules/subscriptionDetail/view/subscription_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class BudgetDetailSuccessView extends StatelessWidget {
  BudgetDetailSuccessView({
    required this.budget,
    Key? key,
  }) : super(key: key);

  final Budget budget;

  final _segmentOptions = {
    0: ' ${FiicoLocale().summaryPerCycle} ',
    1: ' ${FiicoLocale().linearGraph} '
  };
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _headerView(context),
          _bodyView(context),
        ],
      ),
    );
  }

  Widget _headerView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 110,
      decoration: BoxDecoration(
        color: FiicoColors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: BudgetDetailHeaderView(
        budget: budget,
        onNewIconSelected: (icon) {
          var _budget = budget.copyWith(icon: icon);
          context
              .read<BudgetDetailBloc>()
              .add(BudgetUpdateDetailRequest(budget: _budget));
        },
      ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.twenyFour,
              ),
              child: _inputsListView(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputsListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _resumeBoards(context),
        _infoResumeBalanceView(context),
        _historyFinalCycles(context),
        _historySwitchOption(context),
        _movementsDetailView(context),
        _infoCycleDetailView(context),
        _infoPeriodDurationDetailView(context),
        _debtsView(context),
        _debtDailyView(context),
        _debtsListView(context),
        _entrysView(context),
        _entryListView(context),
        _infoView(),
        _entryUsersListView(context),
        _shareButtonView(context),
      ],
    );
  }

  Widget _historyFinalCycles(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.72;
    return Visibility(
      visible: budget.isShowHistoryBudget(),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: FiicoPaddings.twenyFour,
            ),
            child: SeparatorView(),
          ),
          SizedBox(
            width: width,
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                BudgetChartCircleView(
                  width: width,
                  budget: budget,
                  dropdownvalue:
                      context.read<BudgetDetailBloc>().state.dropdownIndex,
                ),
                BudgetLinearChartHistory(
                  width: width,
                  budget: budget,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _historySwitchOption(BuildContext context) {
    final _segmendIndex = context.read<BudgetDetailBloc>().state.segmentIndex;
    return Visibility(
      visible: budget.isShowSwitcherHistoryBudget(),
      child: Container(
        height: 60,
        width: double.maxFinite,
        alignment: Alignment.bottomCenter,
        child: CupertinoSlidingSegmentedControl<int>(
          groupValue: _segmendIndex,
          backgroundColor: FiicoColors.white,
          thumbColor: FiicoColors.pink,
          children: {
            0: _generateSegmentView(_segmendIndex, 0),
            1: _generateSegmentView(_segmendIndex, 1),
          },
          onValueChanged: (index) => _scrollTo(context, index),
        ),
      ),
    );
  }

  Widget _generateSegmentView(int? selectedSegment, int index) {
    final key = _segmentOptions.keys.elementAt(index);
    return Text(
      _segmentOptions.values.elementAt(index),
      textAlign: TextAlign.center,
      style: Style.subtitle.copyWith(
        color: key == selectedSegment
            ? FiicoColors.black
            : FiicoColors.grayNeutral,
      ),
    );
  }

  /// MARK: - Resumen de costos de la tabla seleccionada
  Widget _resumeBoards(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.maxFinite,
      height: 50,
      padding: const EdgeInsets.only(
        left: FiicoPaddings.eight,
        right: FiicoPaddings.eight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Detalle de tabla  ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ingresos -----------------------------------------
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: FiicoPaddings.eight,
                        ),
                        child: SvgPicture.asset(
                          SVGImages.arrowUp,
                          height: 23,
                          width: 23,
                        ),
                      ),
                      Text(
                        budget.totalEntry?.toCurrencyCompat() ?? '',
                        style: Style.title.copyWith(
                          color: FiicoColors.grayDark,
                          fontSize: FiicoFontSize.lg,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: FiicoPaddings.twenyFour,
                    ),
                    child: Text(
                      FiicoLocale().incomes,
                      style: Style.desc.copyWith(
                        color: FiicoColors.grayNeutral,
                        fontSize: FiicoFontSize.xxs,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: FiicoLineHeight.normal,
                color: FiicoColors.white,
                height: 25,
              ),
              // Gastos -----------------------------------------
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: FiicoPaddings.eight,
                        ),
                        child: SvgPicture.asset(
                          SVGImages.arrowDown,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      Text(
                        budget.totalDebt?.toCurrencyCompat() ?? '',
                        style: Style.title.copyWith(
                          color: FiicoColors.grayDark,
                          fontSize: FiicoFontSize.lg,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: FiicoPaddings.twenyFour,
                    ),
                    child: Text(
                      FiicoLocale().outcomes,
                      style: Style.desc.copyWith(
                        color: FiicoColors.grayNeutral,
                        fontSize: FiicoFontSize.xxs,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: FiicoLineHeight.normal,
                color: FiicoColors.white,
                height: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoResumeBalanceView(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            bottom: FiicoPaddings.twenyFour,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              FiicoLocale().balanceTodayIs,
              maxLines: FiicoMaxLines.two,
              overflow: TextOverflow.fade,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayDark,
                fontSize: FiicoFontSize.xm,
              ),
            ),
            Text(
              budget.getTotalBalance().toCurrencyCompat(),
              maxLines: FiicoMaxLines.two,
              overflow: TextOverflow.fade,
              style: Style.title.copyWith(
                color: FiicoColors.grayDark,
                fontSize: FiicoFontSize.xm,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _infoCycleDetailView(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: FiicoPaddings.twenyFour,
            bottom: FiicoPaddings.twenyFour,
          ),
          child: SeparatorView(),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                right: FiicoPaddings.eight,
              ),
              child: Icon(
                MdiIcons.syncIcon,
                color: FiicoColors.grayDark,
              ),
            ),
            Expanded(
              child: Text(
                budget.getDurationBudgetDescription(),
                maxLines: FiicoMaxLines.two,
                overflow: TextOverflow.fade,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.grayNeutral,
                  fontSize: FiicoFontSize.xm,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _infoPeriodDurationDetailView(BuildContext context) {
    return Visibility(
      visible: !(budget.isCycle ?? false),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: FiicoPaddings.twenyFour,
              bottom: FiicoPaddings.twenyFour,
            ),
            child: SeparatorView(),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: FiicoPaddings.eight,
                ),
                child: Icon(
                  MdiIcons.calendarStart,
                  color: FiicoColors.grayDark,
                ),
              ),
              Expanded(
                child: Text(
                  '${FiicoLocale().finalDate} ${budget.startDate?.toDate().toDateFormat2()}',
                  maxLines: FiicoMaxLines.two,
                  overflow: TextOverflow.fade,
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.grayNeutral,
                    fontSize: FiicoFontSize.xm,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.sixteen,
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: FiicoPaddings.eight,
                  ),
                  child: Icon(
                    MdiIcons.calendarEnd,
                    color: FiicoColors.grayDark,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${FiicoLocale().finalDate}:  ${budget.finishDate?.toDate().toDateFormat2()}',
                    maxLines: FiicoMaxLines.two,
                    overflow: TextOverflow.fade,
                    style: Style.subtitle.copyWith(
                      color: FiicoColors.grayNeutral,
                      fontSize: FiicoFontSize.xm,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _movementsDetailView(BuildContext context) {
    return Visibility(
      visible: !budget.isEmptyMovements(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.twenyFour,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SeparatorView(),
            Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FiicoButton(
                      title: FiicoLocale().showMovements,
                      color: FiicoColors.white,
                      borderColor: FiicoColors.grayDark,
                      textColor: FiicoColors.grayDark,
                      onTap: () => FiicoRoute.send(
                        context,
                        MovementsListPage(budget: budget),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entrysView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SeparatorView(),
        Container(
          alignment: Alignment.center,
          height: 60,
          padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                FiicoLocale().incomes,
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _entryListView(BuildContext context) {
    final _mEntrys = budget.getMovementsBy(3) ?? [];
    return Column(
      children: [
        Visibility(
          visible: _mEntrys.isNotEmpty,
          child: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 90.0 * _mEntrys.length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _mEntrys.length,
              itemBuilder: (context, index) {
                final movement = _mEntrys[index];
                return _itemMovementToList(context, movement);
              },
            ),
          ),
        ),
        Visibility(
          visible: budget.isReadAndWriteOnly,
          child: Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.eight,
              bottom: FiicoPaddings.thirtyTwo,
            ),
            child: BudgetDetailAddMovementView(
              title: FiicoLocale().addNewIncome,
              onAdded: () => DefaultMovementPage().show(
                context,
                budget: budget,
                list: MovementsList.getListBy(type: MovementType.ENTRY),
                onMovementSelected: (movement) =>
                    _editDefaultMovement(context, movement),
                onNewItemSelected: () =>
                    _addedMovement(context, MovementType.ENTRY),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _debtDailyView(BuildContext context) {
    final _mDailyDebts = budget.getMovementsBy(7) ?? [];
    return Visibility(
      visible: _mDailyDebts.isNotEmpty,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        width: double.maxFinite,
        height: 75.0 * _mDailyDebts.length,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _mDailyDebts.length,
          itemBuilder: (context, index) {
            final movement = _mDailyDebts[index];
            return _itemMovementToList(context, movement);
          },
        ),
      ),
    );
  }

  Widget _debtsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SeparatorView(),
          Container(
            alignment: Alignment.center,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: FiicoPaddings.thirtyTwo,
                  ),
                  child: Text(
                    FiicoLocale().outcomes,
                    textAlign: TextAlign.start,
                    style: Style.subtitle.copyWith(
                      fontSize: FiicoFontSize.sm,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _debtsListView(BuildContext context) {
    final _mDebts = budget.getMovementsBy(4) ?? [];
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: Column(
        children: [
          Visibility(
            visible: _mDebts.isNotEmpty,
            child: Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 90.0 * _mDebts.length,
              color: Colors.white,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _mDebts.length,
                itemBuilder: (context, index) {
                  final movement = _mDebts[index];
                  return _itemMovementToList(context, movement);
                },
              ),
            ),
          ),
          Visibility(
            visible: budget.isReadAndWriteOnly,
            child: Padding(
              padding: const EdgeInsets.only(
                top: FiicoPaddings.eight,
                bottom: FiicoPaddings.thirtyTwo,
              ),
              child: BudgetDetailAddMovementView(
                title: FiicoLocale().addNewOutcome,
                onAdded: () => DefaultMovementPage().show(
                  context,
                  budget: budget,
                  list: MovementsList.getListBy(type: MovementType.DEBT),
                  onMovementSelected: (movement) =>
                      _editDefaultMovement(context, movement),
                  onNewItemSelected: () =>
                      _addedMovement(context, MovementType.DEBT),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemMovementToList(BuildContext context, Movement movement) {
    return Dismissible(
      key: Key(movement.id ?? ''),
      direction: movement.getType() != MovementType.DAILY_DEBT
          ? DismissDirection.endToStart
          : DismissDirection.none,
      onDismissed: (direction) {
        context.read<BudgetDetailBloc>().add(BudgetDetailMovementRemoveRequest(
            movement: movement, budget: budget));
      },
      confirmDismiss: (direction) async {
        return BottomDialog().show(
          context,
          title:
              '${FiicoLocale().doYouWantToDelete} ${movement.name} ${FiicoLocale().of} ${movement.budgetName}?',
          titleButton: FiicoLocale().deleteButton,
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
      child: BudgetDetailMovementListItemView(
        movement: movement,
        budget: budget,
      ),
    );
  }

  Widget _infoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SeparatorView(),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          height: 90,
          child: Text(
            budget.isOwner
                ? FiicoLocale().shareThisBudget
                : '${budget.ownerName} ${FiicoLocale().hasSharedBudgetWithYou}',
            textAlign: TextAlign.start,
            maxLines: FiicoMaxLines.ten,
            style: Style.desc.copyWith(
              fontSize: FiicoFontSize.xm,
              color: FiicoColors.grayNeutral,
            ),
          ),
        ),
      ],
    );
  }

  Widget _shareButtonView(BuildContext context) {
    return Visibility(
      visible: budget.isOwner,
      child: GestureDetector(
        onTap: () => _onShareBudgetWithUsers(context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: FiicoPaddings.sixteen,
            bottom: FiicoPaddings.thirtyTwo,
          ),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(
                FiicoPaddings.eight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.ios_share,
                    size: 20,
                    color: FiicoColors.purpleSoft,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: FiicoPaddings.eight,
                    ),
                    child: Text(
                      FiicoLocale().shareButton,
                      textAlign: TextAlign.start,
                      style: Style.desc.copyWith(
                        fontSize: FiicoFontSize.xm,
                        color: FiicoColors.purpleSoft,
                      ),
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: FiicoColors.purpleSoft,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryUsersListView(BuildContext context) {
    final users = budget.users ?? [];
    return Visibility(
      visible: users.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _separatorLineView(),
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.thirtyTwo,
              bottom: FiicoPaddings.eight,
            ),
            child: Text(
              FiicoLocale().members,
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: users.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final user = users[index];
                return JustTheTooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  content: Padding(
                    padding: const EdgeInsets.all(FiicoPaddings.sixteen),
                    child: Text(
                      user.userName ?? '',
                      style: Style.subtitle,
                    ),
                  ),
                  child: Container(
                    width: 60,
                    padding: const EdgeInsets.all(FiicoPaddings.eight),
                    child: FiicoProfileNetwork.user(
                      url: user.profileImage,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _separatorLineView() {
    return const SeparatorView();
  }

  void _addedMovement(BuildContext context, MovementType type) async {
    final movement = await FiicoRoute.send(
      context,
      CreateMovementPage(
        budget: budget,
        addedinBudget: true,
        type: type,
      ),
    );
    if (movement is Movement) {
      context.read<BudgetDetailBloc>().add(BudgetDetailMovementAddedRequest(
          newMovement: movement, budget: budget));
    }
  }

  void _editDefaultMovement(BuildContext context, Movement movement) async {
    final newMovement = await FiicoRoute.send(
      context,
      EditMovementPage(
        budget: budget,
        addedinBudget: true,
        movementToEdit: movement,
      ),
    );
    if (newMovement is Movement) {
      context.read<BudgetDetailBloc>().add(BudgetDetailMovementAddedRequest(
          newMovement: newMovement, budget: budget));
    }
  }

  void _onShareBudgetWithUsers(BuildContext context) async {
    final user = await Preferences.get.getUser();
    final users = budget.users ?? [];
    if (user?.isPremium() ?? false) {
      FiicoRoute.send(
        context,
        SearchUsersPage(
          users: users,
          onUsersSelected: (users) => context.read<BudgetDetailBloc>().add(
              BudgetUpdateDetailUsersSelected(users: users, budget: budget)),
        ),
      );
    } else {
      _showErrorUserNotPremium(context);
    }
  }

  void _showErrorUserNotPremium(BuildContext context) async {
    final user = await Preferences.get.getUser();
    PremiumUpdatePage().show(context, onUpdateIntent: () {
      FiicoRoute.send(
        context,
        PremiumPage(
          user: user,
          showPlan: (plan) {
            final newUser = user?.copyWith(currentPlan: plan);
            FiicoRoute.send(context, SubscriptionDetailPage(user: newUser));
          },
        ),
      );
    });
  }

  void _scrollTo(BuildContext context, int? index) {
    context
        .read<BudgetDetailBloc>()
        .add(BudgetSegmentIndexRequest(index: index));
    final posistion = index == 0
        ? controller.position.minScrollExtent
        : controller.position.maxScrollExtent;
    controller.animateTo(
      posistion,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
