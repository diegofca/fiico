import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationsListItemView extends StatefulWidget {
  const NotificationsListItemView({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<NotificationsListItemView> createState() =>
      NotificationsListItemViewState();
}

class NotificationsListItemViewState extends State<NotificationsListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
        decoration: BoxDecoration(
          border: Border.all(
            color: FiicoColors.purpleDark,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _body(),
            _separatorView(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        left: FiicoPaddings.eight,
        bottom: FiicoPaddings.sixteen,
      ),
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _icon(),
          _titleAndDesc(),
        ],
      ),
    );
  }

  Widget _separatorView() {
    return Container(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      margin: const EdgeInsets.symmetric(horizontal: FiicoPaddings.sixteen),
      color: FiicoColors.graySoft,
      height: 1,
    );
  }

  Widget _titleAndDesc() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.twenyFour,
              right: FiicoPaddings.sixteen,
              left: FiicoPaddings.eight,
              bottom: FiicoPaddings.four,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Danu awda wd",
                    style: Style.title.copyWith(
                      color: FiicoColors.purpleDark,
                      fontSize: FiicoFontSize.xm,
                    ),
                  ),
                ),
                Text(
                  "21 de Abril",
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.graySoft,
                    fontSize: FiicoFontSize.xxs,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(FiicoPaddings.eight),
            child: Text(
              "Aún no tienes not",
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xm,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      margin: const EdgeInsets.only(top: FiicoPaddings.twenyFour),
      width: 50,
      child: const Icon(
        MdiIcons.emailFast,
        color: FiicoColors.purpleDark,
        size: 30,
      ),
    );
  }
}
