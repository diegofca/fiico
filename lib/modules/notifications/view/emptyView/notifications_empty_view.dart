import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationsEmptyView extends StatefulWidget {
  const NotificationsEmptyView({
    Key? key,
    required this.onTapNewBudget,
  }) : super(key: key);

  final VoidCallback onTapNewBudget;

  @override
  State<NotificationsEmptyView> createState() => NotificationsEmtpyViewState();

  Size get preferredSize => throw UnimplementedError();
}

class NotificationsEmtpyViewState extends State<NotificationsEmptyView> {
  @override
  Widget build(BuildContext context) {
    return _emptyMyNotifications();
  }

  Widget _emptyMyNotifications() {
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
          Padding(
            padding: const EdgeInsets.only(bottom: FiicoPaddings.thirtyTwo),
            child: SvgPicture.asset(
              SVGImages.emotyNot,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(FiicoPaddings.eight),
            child: Text(
              "No tienes notificaciones aún.",
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.xm,
                color: FiicoColors.graySoft,
              ),
            ),
          ),
          Text(
            "Intenta invitar a algun amigo a tu board.",
            style: Style.subtitle.copyWith(
              fontSize: FiicoFontSize.xm,
              color: FiicoColors.graySoft,
            ),
          ),
          _createButtonView()
        ],
      ),
    );
  }

  Widget _createButtonView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.twenyFour),
      child: SizedBox(
        child: FiicoButton.green(
          title: "Invitar amigo",
          ontap: () => widget.onTapNewBudget.call(),
        ),
      ),
    );
  }
}
