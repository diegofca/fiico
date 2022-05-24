import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/helpCenterMessage.dart';
import 'package:flutter/material.dart';

class HelpCenterDateView extends StatelessWidget {
  const HelpCenterDateView({Key? key, required this.message}) : super(key: key);

  final HelpCenterMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: DateChip(
        date: message.createdAt?.toDate() ?? DateTime.now(),
        color: FiicoColors.purpleSoft.withOpacity(0.2),
      ),
    );
  }
}
