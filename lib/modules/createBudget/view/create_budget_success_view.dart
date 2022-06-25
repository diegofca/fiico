import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_profile_image.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/createBudget/bloc/create_budget_bloc.dart';
import 'package:control/modules/createBudget/view/create_budget_cycle_view.dart';
import 'package:control/modules/createBudget/view/headerView/create_budget_header_view.dart';
import 'package:control/modules/createBudget/view/listView/create_budget_movement_item_list_view.dart';
import 'package:control/modules/createMovement/view/create_movement_page.dart';
import 'package:control/modules/defaultsMovement/repository/daily_debts/default_daily_debt_movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/view/default_movement_page.dart';
import 'package:control/modules/editMovement/view/edit_movement_page.dart';
import 'package:control/modules/premium/view/premium_page.dart';
import 'package:control/modules/premiumUpdate/view/premium_update_page.dart';
import 'package:control/modules/searchUsers/view/search_users_page.dart';
import 'package:control/modules/subscriptionDetail/view/subscription_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CreateBudgetSuccessView extends StatelessWidget {
  const CreateBudgetSuccessView({
    required this.budgetToCreate,
    Key? key,
    this.mDebts,
    this.mEntrys,
    this.mDailyDebts,
    this.users,
  }) : super(key: key);

  final Budget budgetToCreate;

  final List<FiicoUser>? users;
  final List<Movement>? mDebts;
  final List<Movement>? mEntrys;
  final List<Movement>? mDailyDebts;

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
      child: CreateBudgetHeaderView(
        budget: budgetToCreate,
        onNewIconSelected: (icon) {
          context
              .read<CreateBudgetBloc>()
              .add(CreateBudgetInfoSelected(icon: icon));
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
        _entryMoneyView(context),
        _entryDurationView(context),
        _isDailyDebtSwitchView(context),
        _entrysView(context),
        _entryListView(context),
        _debtsView(context),
        _debtDailyView(context),
        _debtsListView(),
        _infoView(),
        _entryUsersListView(context),
        _shareButtonView(context),
        _separatorLineView(),
        _createButtonView(context),
      ],
    );
  }

  Widget _entryMoneyView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.sixteen,
          ),
          child: Text(
            FiicoLocale().currency,
            textAlign: TextAlign.start,
            style: Style.subtitle.copyWith(
              fontSize: FiicoFontSize.sm,
            ),
          ),
        ),
        BorderContainer(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: FiicoPaddings.sixteen,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    budgetToCreate.currency ?? '',
                    textAlign: TextAlign.left,
                    style: Style.subtitle.copyWith(
                      color: FiicoColors.grayNeutral,
                      fontSize: FiicoFontSize.sm,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _showCurrencyPicker(context),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: FiicoColors.pink,
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _entryDurationView(BuildContext context) {
    return CreateBudgetCycleView(budgetToCreate: budgetToCreate);
  }

  Widget _isDailyDebtSwitchView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                FiicoLocale().doYouHaveDailyExpenses,
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
            value: budgetToCreate.isActiveDailyeDebt(),
            activeColor: FiicoColors.pink,
            onChanged: (isActive) {
              final bloc = context.read<CreateBudgetBloc>();
              bloc.add(CreateBudgetInfoSelected(isDailyDebt: isActive));

              if (isActive) {
                bloc.add(CreateBudgetAddedmovement(
                  movement: DailyDebtsMovements.daily(budgetToCreate),
                ));
              } else {
                bloc.add(CreateBudgetRemovedMovement(
                  movement: DailyDebtsMovements.daily(budgetToCreate),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _debtDailyView(BuildContext context) {
    final _mDailyDebts = mDailyDebts ?? [];
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

  Widget _entrysView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _separatorLineView(),
          Container(
            alignment: Alignment.center,
            height: 75,
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
                IconButton(
                  onPressed: () => _addedMovement(context, MovementType.ENTRY),
                  icon: const Icon(
                    MdiIcons.plusCircleOutline,
                    color: FiicoColors.pink,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryListView(BuildContext context) {
    final _mEntrys = mEntrys ?? [];
    return Visibility(
      visible: _mEntrys.isNotEmpty,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        width: double.maxFinite,
        height: 75.0 * _mEntrys.length,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _mEntrys.length,
          itemBuilder: (context, index) {
            final movement = _mEntrys[index];
            return _itemMovementToList(context, movement);
          },
        ),
      ),
    );
  }

  Widget _debtsView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _separatorLineView(),
        Container(
          alignment: Alignment.center,
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                FiicoLocale().outcomes,
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
              IconButton(
                onPressed: () => _addedMovement(context, MovementType.DEBT),
                icon: const Icon(
                  MdiIcons.plusCircleOutline,
                  color: FiicoColors.pink,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _debtsListView() {
    final _mDebts = mDebts ?? [];
    return Visibility(
      visible: _mDebts.isNotEmpty,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        width: double.maxFinite,
        height: 75.0 * _mDebts.length,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _mDebts.length,
          itemBuilder: (context, index) {
            final movement = _mDebts[index];
            return _itemMovementToList(context, movement);
          },
        ),
      ),
    );
  }

  Widget _itemMovementToList(BuildContext context, Movement movement) {
    return Dismissible(
      key: Key(movement.id ?? ''),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context
            .read<CreateBudgetBloc>()
            .add(CreateBudgetRemovedMovement(movement: movement));
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
      child: CreateBudgetMovementListItemView(
        movement: movement,
        budget: budgetToCreate,
      ),
    );
  }

  Widget _infoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _separatorLineView(),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.thirtyTwo,
          ),
          child: Text(
            FiicoLocale().youCanCreateAndShareBoards,
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
    return GestureDetector(
      onTap: () => _onShareBudgetWithUsers(context),
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.thirtyTwo,
        ),
        child: SizedBox(
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

  Widget _createButtonView(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: FiicoButton.pink(
        title: FiicoLocale().createBudget,
        ontap: () => _onCreateBudgetIntent(context),
      ),
    );
  }

  Widget _entryUsersListView(BuildContext context) {
    final users = context.read<CreateBudgetBloc>().state.users ?? [];
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
                return Container(
                  width: 60,
                  padding: const EdgeInsets.all(FiicoPaddings.eight),
                  child: FiicoProfileNetwork.user(
                    url: user.profileImage,
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

  void _onCreateBudgetIntent(BuildContext context) async {
    final isCreateAvailable = await FiicoRemoteConfig.isCanCreateBudget();
    if (budgetToCreate.isCompleteByCreate() && isCreateAvailable) {
      final movements = budgetToCreate.movements
          ?.map((e) => e.copyWith(currency: budgetToCreate.currency))
          .toList();
      final finalBudget = budgetToCreate.copyWith(movements: movements);
      context
          .read<CreateBudgetBloc>()
          .add(CreateBudgetAdded(budget: finalBudget));
    } else if (!isCreateAvailable) {
      _showErrorUserNotPremium(context);
    } else {
      _showErrorIncompleteBudgetData(context);
    }
  }

  void _onShareBudgetWithUsers(BuildContext context) async {
    final user = await Preferences.get.getUser();
    if (user?.isPremium() ?? false) {
      FiicoRoute.send(
        context,
        SearchUsersPage(
          users: users,
          onUsersSelected: (users) {
            context
                .read<CreateBudgetBloc>()
                .add(CreateBudgetSearchUsersSelected(users: users));
          },
        ),
      );
    } else {
      _showErrorUserNotPremium(context);
    }
  }

  void _showCurrencyPicker(BuildContext context) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (currency) {
        context
            .read<CreateBudgetBloc>()
            .add(CreateBudgetInfoSelected(currency: currency));
      },
      theme: CurrencyPickerThemeData(
        titleTextStyle: Style.subtitle.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
        subtitleTextStyle: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  void _addedMovement(BuildContext context, MovementType type) async {
    if (budgetToCreate.isCompleteByCreate()) {
      DefaultMovementPage().show(
        context,
        budget: budgetToCreate,
        list: MovementsList.getListBy(type: type),
        onMovementSelected: (movement) =>
            _selectPredefinedMovement(context, movement),
        onNewItemSelected: () => _addNewMovement(context, type),
      );
    } else {
      _showErrorIncompleteBudgetData(context);
    }
  }

  // Se crearia un movimiento desde una plantilla predefinida
  void _selectPredefinedMovement(
      BuildContext context, Movement movement) async {
    final bloc = context.read<CreateBudgetBloc>();
    Movement newMovement = await FiicoRoute.send(
      context,
      EditMovementPage(
        budget: budgetToCreate,
        movementToEdit: movement,
        addedinBudget: true,
      ),
    );
    bloc.add(CreateBudgetAddedmovement(movement: newMovement));
  }

  // Se crearia un movimiento desde cero.
  void _addNewMovement(BuildContext context, MovementType type) async {
    final bloc = context.read<CreateBudgetBloc>();
    Movement movement = await FiicoRoute.send(
      context,
      CreateMovementPage(
        budget: budgetToCreate,
        addedinBudget: true,
        type: type,
      ),
    );
    bloc.add(CreateBudgetAddedmovement(movement: movement));
  }

  void _showErrorIncompleteBudgetData(BuildContext context) {
    FiicoAlertDialog.showWarnning(
      context,
      title: FiicoLocale().emptyFields,
      message: FiicoLocale().completeMissingFieldsAddMovement,
    );
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
}
