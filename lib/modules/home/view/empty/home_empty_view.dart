import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeEmptyView extends StatefulWidget {
  const HomeEmptyView({
    Key? key,
    this.onTapNewItem,
    this.onTapNewBudget,
    required this.isContaintBudgets,
  }) : super(key: key);

  final bool isContaintBudgets;
  final VoidCallback? onTapNewItem;
  final VoidCallback? onTapNewBudget;

  @override
  State<HomeEmptyView> createState() => HomeEmtpyViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeEmtpyViewState extends State<HomeEmptyView> {
  final _imageTopHeigth = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      color: FiicoColors.white,
      padding: const EdgeInsets.only(top: FiicoPaddings.twenyFour),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          _imageTop(),
          _emptyText(),
          _bodyButton(),
        ],
      ),
    );
  }

  Widget _imageTop() {
    return SvgPicture.asset(
      SVGImages.emptySafe,
      height: _imageTopHeigth,
    );
  }

  Widget _emptyText() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Text(
        "Añade todos tus gastos y apoderate de ellos.",
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
        ),
      ),
    );
  }

  Widget _bodyButton() {
    return FiicoButton.green(
      ontap: () => widget.isContaintBudgets
          ? widget.onTapNewItem!.call()
          : widget.onTapNewBudget!.call(),
      title: widget.isContaintBudgets
          ? ' Agregar movimiento'
          : 'Crear presupuesto',
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
    );
  }
}
