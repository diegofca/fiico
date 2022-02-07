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
    required this.onTapNewItem,
  }) : super(key: key);

  final VoidCallback onTapNewItem;

  @override
  State<HomeEmptyView> createState() => HomeEmtpyViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeEmtpyViewState extends State<HomeEmptyView> {
  final _imageTopHeigth = 160.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.0,
      color: FiicoColors.white,
      padding: const EdgeInsets.only(top: FiicoPaddings.twenyFour),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Text(
        "No tienes moviemientos recientes",
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
        ),
      ),
    );
  }

  Widget _bodyButton() {
    return FiicoButton.green(
      ontap: widget.onTapNewItem,
      title: "Agregar movimiento",
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
    );
  }
}
