import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeSliverAppBar extends SliverAppBar {
  const HomeSliverAppBar(
    this.opacity, {
    required this.isHideBoards,
    Key? key,
  }) : super(key: key);

  final double opacity;
  final bool isHideBoards;

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

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: _resumeBoards(),
      flexibleSpace: _flexibleWidgets(),
      backgroundColor: FiicoColors.purpleDark,
      floating: false,
      collapsedHeight: widget.isHideBoards ? 0 : _heigthTitleWidget,
      toolbarHeight: widget.isHideBoards ? 0 : _heigthTitleWidget,
      expandedHeight:
          widget.isHideBoards ? _minExpandedHeight : _maxExpandedHeight,
      titleSpacing: 0,
      pinned: true,
      stretch: true,
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
        padding: const EdgeInsets.symmetric(
          horizontal: FiicoPaddings.twenyFour,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(
                  "Mi budget",
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.purpleLite,
                    fontSize: FiicoFontSize.sm,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: FiicoColors.pink,
                ),
              ],
            ),
            // Detalle de tabla  ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "\$ 3 M",
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
                        "Ingresos",
                        style: Style.desc.copyWith(
                          color: FiicoColors.purpleSoft,
                          fontSize: FiicoFontSize.xxs,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
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
                          "\$ 1 M",
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
                        "Gastos",
                        style: Style.desc.copyWith(
                          color: FiicoColors.purpleSoft,
                          fontSize: FiicoFontSize.xxs,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1,
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
                          "\$ 13 K",
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
                        "Saldo",
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
  Widget _flexibleWidgets() {
    return AnimatedOpacity(
      opacity: getOpacity(),
      curve: Curves.bounceIn,
      duration: flexDuration,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _searchWidget(),
            _menuButtonsWidget(),
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

    return Container(
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
              left: FiicoPaddings.sixteen,
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
                Text(
                  'Busca tus boards aqui o ingresos aquí',
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.purpleSoft,
                    fontSize: FiicoFontSize.xs,
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
    );
  }

  /// MARK: - Listado de botones de acceso rapido
  Widget _menuButtonsWidget() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: _heigthButtonsWidget,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buttonAction(SVGImages.addEntry, "Add entry", () {}),
            _buttonAction(SVGImages.addDebt, "Add debt", () {}),
            _buttonAction(SVGImages.addBudget, "Add group", () {}),
            _buttonAction(SVGImages.budgetList, "My groups", () {}),
          ],
        ),
      ),
    );
  }

  /// MARK: - Boton de acceso rapido
  Widget _buttonAction(String image, String text, Function onTap) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 4.3,
            child: AspectRatio(
              aspectRatio: 1 / 1.03,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: FiicoPaddings.sixteen,
                  right: FiicoPaddings.eight,
                  left: FiicoPaddings.eight,
                  bottom: FiicoPaddings.eight,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
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
          Container(
            alignment: Alignment.bottomCenter,
            height: 20,
            child: Text(
              text,
              style: Style.subtitle.copyWith(
                color: FiicoColors.purpleLite,
                fontSize: FiicoFontSize.xs,
              ),
            ),
          )
        ],
      ),
    );
  }

  double getOpacity() {
    var opacity = (widget.opacity / 100) - 0.6;
    opacity = opacity <= -0 ? 0 : opacity;
    opacity = opacity >= 1 ? 1 : opacity;
    return 1 - opacity;
  }
}
