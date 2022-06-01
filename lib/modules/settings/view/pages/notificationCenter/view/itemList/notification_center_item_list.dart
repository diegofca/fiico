import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/models/notification_center_option.dart';
import 'package:flutter/material.dart';

class NotificationCenterListItemView extends StatefulWidget {
  const NotificationCenterListItemView({
    Key? key,
    required this.option,
    required this.onUpdateOption,
  }) : super(key: key);

  final NotificationCenterOption? option;
  final Function(NotificationCenterOption?) onUpdateOption;

  @override
  State<NotificationCenterListItemView> createState() =>
      NotificationCenterListItemViewState();
}

class NotificationCenterListItemViewState
    extends State<NotificationCenterListItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.eight),
      child: Container(
        color: FiicoColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _nameSettingItem(),
                _iconFlagView(),
              ],
            ),
            _separatorLine()
          ],
        ),
      ),
    );
  }

  Widget _nameSettingItem() {
    return Text(
      widget.option?.name ?? '',
      style: Style.subtitle.copyWith(
        fontSize: FiicoFontSize.xs,
        color: FiicoColors.grayDark,
      ),
    );
  }

  Widget _iconFlagView() {
    return Container(
      padding: const EdgeInsets.only(
        left: FiicoPaddings.eight,
      ),
      child: Container(
        alignment: Alignment.centerRight,
        child: Switch.adaptive(
          value: widget.option?.enable ?? false,
          activeColor: FiicoColors.pink,
          onChanged: (value) {
            final newOption = widget.option?.copyWith(enable: value);
            widget.onUpdateOption(newOption);
          },
        ),
      ),
    );
  }

  Widget _separatorLine() {
    return const SeparatorView();
  }
}
