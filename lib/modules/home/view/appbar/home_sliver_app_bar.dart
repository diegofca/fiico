import 'dart:async';

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum HomeSliverButtonOptions {
  addEntry,
  addDebt,
  addGroup,
  myGroups,
  calculator
}

class HomeSliverAppBar extends SliverAppBar {
  const HomeSliverAppBar(
    this.opacity, {
    required this.isHideBoards,
    required this.optionTapped,
    required this.onSearchTap,
    required this.onBudgetSelector,
    this.budgetSelected,
    Key? key,
  }) : super(key: key);

  final double opacity;
  final bool isHideBoards;

  final Budget? budgetSelected;

  final Function(HomeSliverButtonOptions) optionTapped;
  final Function(String) onSearchTap;
  final Function() onBudgetSelector;

  @override
  State<HomeSliverAppBar> createState() => _HomeSliverAppBarState();
}

class _HomeSliverAppBarState extends State<HomeSliverAppBar> {
  final double _heigthTitleWidget = 100.0;
  final double _heigthSearchWidget = 180.0;
  final double _heigthButtonsWidget = 120.0;
  final double _heigthResumeWidget = 80.0;
  final double _maxExpandedHeight = 320.0;
  final double _minExpandedHeight = 220.0;
  final flexDuration = const Duration(milliseconds: 10);
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  final _scrollController = ScrollController();
  double step = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (_) {
      step = _scrollController.position.pixels + 100.0;
      if (step >= _scrollController.position.maxScrollExtent) {
        step = _scrollController.position.minScrollExtent;
      }

      _scrollController.animateTo(step,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: _resumeBoards(),
      flexibleSpace: _flexibleWidgets(context),
      backgroundColor: FiicoColors.purpleDark,
      leading: null,
      floating: false,
      collapsedHeight: widget.isHideBoards ? 0 : _heigthTitleWidget,
      toolbarHeight: widget.isHideBoards ? 0 : _heigthTitleWidget,
      expandedHeight:
          widget.isHideBoards ? _minExpandedHeight : _maxExpandedHeight,
      titleSpacing: 0,
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: false,
    );
  }

  /// MARK: - Resumen de costos de la tabla seleccionada
  Widget _resumeBoards() {
    return Visibility(
      visible: !widget.isHideBoards,
      child: Container(
        alignment: Alignment.topCenter,
        width: double.maxFinite,
        height: _heigthResumeWidget,
        padding: const EdgeInsets.only(
          left: FiicoPaddings.eight,
          right: FiicoPaddings.eight,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => widget.onBudgetSelector.call(),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: FiicoPaddings.twenyFour,
                  bottom: FiicoPaddings.eight,
                ),
                child: Row(
                  children: [
                    Text(
                      widget.budgetSelected?.name ?? '',
                      style: Style.subtitle.copyWith(
                        color: FiicoColors.purpleLite,
                        fontSize: FiicoFontSize.xm,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: FiicoColors.pink,
                    ),
                  ],
                ),
              ),
            ),
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
                          widget.budgetSelected?.totalEntry
                                  ?.toCurrencyCompat() ??
                              '',
                          style: Style.subtitle.copyWith(
                            color: FiicoColors.white,
                            fontSize: FiicoFontSize.xs,
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
                          color: FiicoColors.purpleSoft,
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
                          widget.budgetSelected?.totalDebt
                                  ?.toCurrencyCompat() ??
                              '',
                          style: Style.subtitle.copyWith(
                            color: FiicoColors.white,
                            fontSize: FiicoFontSize.xs,
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
                          color: FiicoColors.purpleSoft,
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
                // Saldo -----------------------------------------
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: FiicoPaddings.eight,
                          ),
                          child: SvgPicture.asset(
                            SVGImages.equal,
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Text(
                          widget.budgetSelected?.totalBalance
                                  ?.toCurrencyCompat() ??
                              '',
                          style: Style.subtitle.copyWith(
                            color: FiicoColors.white,
                            fontSize: FiicoFontSize.xs,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: FiicoPaddings.twenyFour,
                      ),
                      child: Text(
                        FiicoLocale().balance,
                        style: Style.desc.copyWith(
                          color: FiicoColors.purpleSoft,
                          fontSize: FiicoFontSize.xxs,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// MARK: - Listado de vistas secundarias
  Widget _flexibleWidgets(BuildContext context) {
    return AnimatedOpacity(
      opacity: getOpacity(),
      curve: Curves.bounceIn,
      duration: flexDuration,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _searchWidget(),
            _menuButtonsWidget(context),
          ],
        ),
      ),
    );
  }

  /// MARK: -  Barra de busqueda en el app bar
  Widget _searchWidget() {
    double heigth = widget.isHideBoards
        ? _heigthSearchWidget - _heigthTitleWidget
        : _heigthSearchWidget;

    double topPadding = widget.isHideBoards ? 0 : _heigthTitleWidget;

    return GestureDetector(
      onTap: () => _onSearchAction(),
      child: Container(
        alignment: Alignment.topCenter,
        height: heigth,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.twenyFour,
              vertical: FiicoPaddings.eight,
            ),
            child: Container(
              height: double.maxFinite,
              padding: const EdgeInsets.only(
                left: FiicoPaddings.eight,
                right: FiicoPaddings.eight,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(FiicoPaddings.eight),
                color: FiicoColors.purpleNeutral,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  Placeholder de busqueda
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: FiicoPaddings.six,
                      ),
                      child: FiicoTextfield(
                        hintText: FiicoLocale().findYourUserOrMovements,
                        textEditingController: _controller,
                        focusNode: _focusNode,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _onSearchAction(),
                        textStyle: Style.subtitle.copyWith(
                          color: FiicoColors.purpleSoft,
                          fontSize: FiicoFontSize.xs,
                        ),
                      ),
                    ),
                  ),
                  //  Icono de busqueda
                  Container(
                    height: 45,
                    width: 45,
                    margin: const EdgeInsets.only(
                      right: FiicoPaddings.two,
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 30,
                      color: FiicoColors.purpleNeutral,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(FiicoPaddings.eight),
                      color: FiicoColors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// MARK: - Listado de botones de acceso rapido
  Widget _menuButtonsWidget(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: _heigthButtonsWidget,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        padding: const EdgeInsets.only(left: FiicoPaddings.sixteen),
        child: Row(
          children: [
            _buttonAction(
              context,
              SVGImages.addEntry,
              FiicoLocale().addIncome,
              () => widget.optionTapped(HomeSliverButtonOptions.addEntry),
            ),
            _buttonAction(
              context,
              SVGImages.addDebt,
              FiicoLocale().addOutcome,
              () => widget.optionTapped(HomeSliverButtonOptions.addDebt),
            ),
            _buttonAction(
              context,
              SVGImages.budgetList,
              FiicoLocale().myBudgets,
              () => widget.optionTapped(HomeSliverButtonOptions.myGroups),
            ),
            _buttonAction(
              context,
              SVGImages.calculator,
              'Calculadora',
              () => widget.optionTapped(HomeSliverButtonOptions.calculator),
            ),
            _buttonAction(
              context,
              SVGImages.addBudget,
              FiicoLocale().addBudget,
              () => widget.optionTapped(HomeSliverButtonOptions.addGroup),
            ),
          ],
        ),
      ),
    );
  }

  /// MARK: - Boton de acceso rapido
  Widget _buttonAction(
      BuildContext context, String image, String text, Function onTap) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4.3,
            child: AspectRatio(
              aspectRatio: 1 / 1.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: FiicoPaddings.sixteen,
                  right: FiicoPaddings.eight,
                  left: FiicoPaddings.eight,
                  bottom: FiicoPaddings.eight,
                ),
                child: Container(
                  padding: const EdgeInsets.all(FiicoPaddings.twenty),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      FiicoPaddings.twenyFour,
                    ),
                    color: FiicoColors.purpleNeutral,
                  ),
                  child: SvgPicture.asset(image),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 30,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Style.subtitle.copyWith(
                  color: FiicoColors.purpleLite,
                  fontSize: FiicoFontSize.xxs,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onSearchAction() {
    if (_controller.text.isNotEmpty) {
      _focusNode.unfocus();
      widget.onSearchTap.call(_controller.text);
    }
  }

  double getOpacity() {
    var opacity = (widget.opacity / 100) - 0.6;
    opacity = opacity <= -0 ? 0 : opacity;
    opacity = opacity >= 1 ? 1 : opacity;
    return 1 - opacity;
  }
}
