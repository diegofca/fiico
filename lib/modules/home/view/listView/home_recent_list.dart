import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeRecentList extends StatefulWidget {
  const HomeRecentList({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeRecentList> createState() => HomeRecentListViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeRecentListViewState extends State<HomeRecentList> {
  final _imageTopHeigth = 160.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1000),
      opacity: true ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 1000),
        padding:
            true ? const EdgeInsets.all(4.0) : const EdgeInsets.only(top: 10),
        child: Container(
          constraints: BoxConstraints.expand(height: 100),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Holi",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
