import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchUsersEmptyView extends StatefulWidget {
  const SearchUsersEmptyView({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchUsersEmptyView> createState() => SearchUsersEmptyViewState();

  Size get preferredSize => throw UnimplementedError();
}

class SearchUsersEmptyViewState extends State<SearchUsersEmptyView> {
  @override
  Widget build(BuildContext context) {
    return _emptyUsers();
  }

  Widget _emptyUsers() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: const [
          BoxShadow(
            color: FiicoColors.grayLite,
            blurRadius: 5,
            spreadRadius: 20,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: FiicoPaddings.thirtyTwo),
            child: Icon(
              MdiIcons.accountSearch,
              color: FiicoColors.grayDark,
              size: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(FiicoPaddings.eight),
            child: Text(
              "No hay Resultados de tu busqueda",
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.xm,
                color: FiicoColors.graySoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
