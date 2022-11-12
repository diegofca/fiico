import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/helpCenterMessage.dart';
import 'package:control/modules/settings/view/pages/helpCenter/view/bubbles/help_buble_test.dart';
import 'package:flutter/material.dart';

class HelpCenterTextView extends StatelessWidget {
  const HelpCenterTextView({Key? key, required this.message}) : super(key: key);

  final HelpCenterMessage message;

  @override
  Widget build(BuildContext context) {
    return HelpBubbleNormal(
      text: message.message ?? '',
      isSender: message.isUserSender ?? true,
      color: message.getBackgroundColor(),
      tail: false,
      textStyle: Style.subtitle.copyWith(
        fontSize: FiicoFontSize.xm,
        color: message.getTextColor(),
      ),
    );
  }
}
