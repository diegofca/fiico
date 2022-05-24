import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FiicoColors.white,
      padding: const EdgeInsets.only(top: FiicoPaddings.thirtyTwo),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 2,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
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
      height: MediaQuery.of(context).size.height / 7,
    );
  }

  Widget _emptyText() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.twenyFour,
      ),
      child: Text(
        FiicoLocale().addAllYourExpensesAndSiezeThem,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
        ),
      ),
    );
  }

  Widget _bodyButton() {
    return FiicoButton.pink(
      ontap: () => widget.isContaintBudgets
          ? widget.onTapNewItem!.call()
          : widget.onTapNewBudget!.call(),
      title: widget.isContaintBudgets
          ? FiicoLocale().addMovement
          : FiicoLocale().createBudget,
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
    );
  }
}
