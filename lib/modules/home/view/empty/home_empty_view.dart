import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeEmptyView extends StatefulWidget {
  const HomeEmptyView({
    Key? key,
    this.onTapNewItem,
    this.onTapNewBudget,
    required this.budget,
  }) : super(key: key);

  final Budget? budget;
  final VoidCallback? onTapNewItem;
  final VoidCallback? onTapNewBudget;

  @override
  State<HomeEmptyView> createState() => HomeEmtpyViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeEmtpyViewState extends State<HomeEmptyView> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.2,
      child: Container(
        color: FiicoColors.white,
        padding: const EdgeInsets.only(bottom: FiicoPaddings.oneHundredTwenty),
        alignment: Alignment.center,
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
    return Visibility(
      visible: widget.budget?.isReadAndWriteOnly ?? false,
      child: FiicoButton.pink(
        ontap: () => widget.budget == null
            ? widget.onTapNewBudget!.call()
            : widget.onTapNewItem!.call(),
        title: widget.budget == null
            ? FiicoLocale().createBudget
            : FiicoLocale().addMovement,
        padding: const EdgeInsets.all(FiicoPaddings.sixteen),
      ),
    );
  }
}
