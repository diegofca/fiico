import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationsListItemView extends StatefulWidget {
  const NotificationsListItemView({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final FiicoNotification notification;

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
        margin: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.notification.readed ?? false
                ? FiicoColors.grayNeutral
                : FiicoColors.purpleDark,
            width: widget.notification.readed ?? false ? 1 : 2,
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
    return Visibility(
      visible: !(widget.notification.readed ?? false),
      child: Container(
        padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
        margin: const EdgeInsets.symmetric(horizontal: FiicoPaddings.sixteen),
        color: FiicoColors.graySoft,
        height: 1,
      ),
    );
  }

  Widget _titleAndDesc() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(
              top: FiicoPaddings.sixteen,
              right: FiicoPaddings.sixteen,
            ),
            child: Text(
              widget.notification.getCreateDate(),
              style: Style.subtitle.copyWith(
                color: FiicoColors.black,
                fontSize: FiicoFontSize.xxxs,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: FiicoPaddings.eight,
              left: FiicoPaddings.eight,
              bottom: FiicoPaddings.four,
            ),
            child: Expanded(
              child: Text(
                widget.notification.title ?? '',
                style: Style.title.copyWith(
                  color: FiicoColors.purpleDark,
                  fontSize: FiicoFontSize.xm,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: FiicoPaddings.eight,
              top: FiicoPaddings.eight,
              right: FiicoPaddings.sixteen,
              bottom: FiicoPaddings.eight,
            ),
            child: Text(
              widget.notification.message ?? '',
              maxLines: FiicoMaxLines.ten,
              style: Style.subtitle.copyWith(
                color: FiicoColors.grayDark,
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
      margin: const EdgeInsets.only(top: FiicoPaddings.thirtyTwo),
      width: 50,
      child: const Icon(
        MdiIcons.emailFast,
        color: FiicoColors.purpleDark,
        size: 30,
      ),
    );
  }
}
