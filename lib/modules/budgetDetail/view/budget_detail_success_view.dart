import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/budgetDetail/bloc/budget_detail_bloc.dart';
import 'package:control/modules/budgetDetail/view/headerView/budget_detail_header_view.dart';
import 'package:control/modules/budgetDetail/view/widgets/budget_detail_add_movement_view.dart';
import 'package:control/modules/createBudget/bloc/create_budget_bloc.dart';
import 'package:control/modules/createBudget/view/listView/create_budget_movement_item_list_view.dart';
import 'package:control/modules/createMovement/view/create_movement_page.dart';
import 'package:control/modules/searchUsers/view/search_users_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class BudgetDetailSuccessView extends StatelessWidget {
  const BudgetDetailSuccessView({
    required this.budget,
    Key? key,
  }) : super(key: key);

  final Budget budget;

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
      child: BudgetDetailHeaderView(name: budget.name),
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
        _entrysView(context),
        _entryListView(context),
        _entrysDebtsView(context),
        _entrysDebtsListView(context),
        _infoView(),
        _shareButtonView(context),
      ],
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
                      "Incomes",
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
                      "Outcomes",
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

  Widget _entrysView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _separatorLineView(),
          Container(
            alignment: Alignment.center,
            height: 60,
            padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Income',
                  textAlign: TextAlign.start,
                  style: Style.subtitle.copyWith(
                    fontSize: FiicoFontSize.sm,
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
        Padding(
          padding: const EdgeInsets.only(
            top: FiicoPaddings.eight,
            bottom: FiicoPaddings.thirtyTwo,
          ),
          child: BudgetDetailAddMovementView(
            title: 'Agregar nuevo ingreso',
            onAdded: () => _addedMovement(context, MovementType.ENTRY),
          ),
        ),
      ],
    );
  }

  Widget _entrysDebtsView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _separatorLineView(),
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
                  'Outcome',
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
    );
  }

  Widget _entrysDebtsListView(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.eight,
              bottom: FiicoPaddings.thirtyTwo,
            ),
            child: BudgetDetailAddMovementView(
              title: 'Agregar nuevo ingreso',
              onAdded: () => _addedMovement(context, MovementType.DEBT),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemMovementToList(BuildContext context, Movement movement) {
    return Dismissible(
      key: Key(movement.id ?? ''),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context
            .read<BudgetDetailBloc>()
            .add(BudgetDetailMovementRemoveRequest(movement: movement));
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
      child: CreateBudgetMovementListItemView(movement: movement),
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
          padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          height: 90,
          child: Text(
            'Comparte este preupuesto con tus amigos y familiares.',
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
      onTap: () => FiicoRoute.send(context, const SearchUsersPage()),
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
                    'Share',
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
    );
  }

  Widget _separatorLineView() {
    return Container(
      color: FiicoColors.graySoft,
      height: 1,
    );
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
      context
          .read<BudgetDetailBloc>()
          .add(BudgetDetailMovementAddedRequest(newMovement: movement));
    }
  }
}
