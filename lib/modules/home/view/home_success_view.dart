// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createBudget/view/create_budget_bottom_view.dart';
import 'package:control/modules/createBudget/view/create_budget_page.dart';
import 'package:control/modules/createMovement/view/create_movement_page.dart';
import 'package:control/modules/home/bloc/home_bloc.dart';
import 'package:control/modules/home/home.dart';
import 'package:control/modules/home/view/widgets/home_bottom_view.dart';
import 'package:control/modules/search/view/search_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'empty/home_empty_view.dart';
import 'listView/home_list_item_view.dart';

class HomeSuccesView extends StatefulWidget {
  HomeSuccesView({
    Key? key,
    required this.budgets,
    this.budgetSelected,
  }) : super(key: key);

  //TEMPORAL
  final List<Budget> budgets;
  final Budget? budgetSelected;
  // Initial Selected Value
  String dropdownvalue = 'Mas recientes';

  // List of items in our dropdown menu
  var itemsFilter = [
    'Mas recientes',
    'De menor a mayor',
    'De mayor a menor',
    'Por tipo',
    'Solo ingresos',
    'Solo gastos',
  ];

  @override
  State<HomeSuccesView> createState() => HomeSuccessViewState();
}

class HomeSuccessViewState extends State<HomeSuccesView> {
  final _controller = ScrollController();
  final _refreshController = RefreshController();

  double opacity = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        opacity = _controller.offset;
      });
    });
  }

  Budget get currentBudget =>
      widget.budgets
          .firstWhereOrNull((e) => e.id == widget.budgetSelected?.id) ??
      widget.budgets.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.white,
      appBar: const HomeAppBar(
        title: HomeTitleAppBar(
          title: "Hi, Juan Camilo",
          subtitle: "Control your money in the best way",
          profileUrl: "",
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: const WaterDropMaterialHeader(
        backgroundColor: FiicoColors.purpleSoft,
        color: FiicoColors.white,
      ),
      onRefresh: () {
        context.read<HomeBloc>().add(const HomeBudgetsFetchRequest(uID: 1));
        Future.delayed(const Duration(seconds: 2), () {
          _refreshController.refreshCompleted();
        });
      },
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          _mainAppBar(context),
          _emptySliverView(context),
          _headerListItemsView(),
          _listItemsView(),
        ],
      ),
    );
  }

  // Bottom App bar Actions button.
  Widget _mainAppBar(BuildContext context) {
    return HomeSliverAppBar(
      opacity,
      isHideBoards: widget.budgets.isEmpty,
      budgetSelected: currentBudget,
      optionTapped: (option) async {
        switch (option) {
          case HomeSliverButtonOptions.addEntry:
            FiicoRoute.send(
              context,
              CreateMovementPage(
                budget: currentBudget,
                type: MovementType.ENTRY,
              ),
            );
            break;
          case HomeSliverButtonOptions.addDebt:
            FiicoRoute.send(
              context,
              CreateMovementPage(
                budget: currentBudget,
                type: MovementType.DEBT,
              ),
            );
            break;
          case HomeSliverButtonOptions.addGroup:
            CreateBottomView().show(context, callbackName: (name) {
              FiicoRoute.send(context, CreateBudgetPage(budgetName: name));
            });
            break;
          case HomeSliverButtonOptions.myGroups:
            FiicoRoute.changeTab(context, TabOption.budgets);
            break;
        }
      },
      onSearchTap: (searchQuery) {
        FiicoRoute.send(context, const SearchPage());
      },
      onBudgetSelector: () {
        HomeBottomView().show(
          context,
          widget.budgets,
          onBudgetSelected: (budget) {
            context.read<HomeBloc>().add(HomeBudgetSelected(budget: budget));
          },
        );
      },
    );
  }

  Widget _headerListItemsView() {
    return SliverVisibility(
      visible: !currentBudget.isEmptyMovements(),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: FiicoPaddings.sixteen,
                right: FiicoPaddings.sixteen,
                top: FiicoPaddings.sixteen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: FiicoPaddings.eight),
                    child: Text(
                      "Movimientos recientes",
                      style: Style.subtitle.copyWith(
                        fontSize: FiicoFontSize.xm,
                      ),
                    ),
                  ),
                  _dropDownFilterView(),
                ],
              ),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }

  Widget _listItemsView() {
    return SliverVisibility(
      visible: !currentBudget.isEmptyMovements(),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final movement = currentBudget.movements![index];
              return HomeListItemView(movement: movement);
            },
            childCount: currentBudget.movements?.length,
          ),
        ),
      ),
    );
  }

  Widget _emptySliverView(BuildContext context) {
    return SliverVisibility(
      visible: currentBudget.isEmptyMovements(),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return HomeEmptyView(
              onTapNewItem: () => FiicoRoute.send(
                context,
                CreateMovementPage(
                  budget: currentBudget,
                  type: MovementType.DEBT,
                ),
              ),
            );
          },
          childCount: 1,
        ),
      ),
    );
  }

  Widget _dropDownFilterView() {
    return DropdownButton(
      value: widget.dropdownvalue,
      elevation: 1,
      underline: Container(),
      alignment: AlignmentDirectional.centerEnd,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: FiicoColors.purpleDark,
      ),
      style: Style.subtitle.copyWith(
        color: FiicoColors.purpleDark,
        fontSize: FiicoFontSize.xm,
      ),
      dropdownColor: Colors.white,
      items: widget.itemsFilter.map((String items) {
        return DropdownMenuItem(
          alignment: Alignment.centerLeft,
          value: items,
          child: Text(
            items,
            textAlign: TextAlign.right,
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.dropdownvalue = newValue!;
        });
      },
    );
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}