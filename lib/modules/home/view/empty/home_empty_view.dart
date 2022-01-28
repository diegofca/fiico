import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeEmptyView extends StatefulWidget {
  const HomeEmptyView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeEmptyView> createState() => HomeEmtpyViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeEmtpyViewState extends State<HomeEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.1,
      color: FiicoColors.white,
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SVGImages.emptySafe,
            height: 160,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "No tienes moviemientos recientes",
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayNeutral,
              ),
            ),
          ),
          const FiicoButton(
            title: "Agregar movimiento",
            image: SVGImages.addBudget,
            padding: EdgeInsets.all(16),
          )
        ],
      ),
    );
  }
}
