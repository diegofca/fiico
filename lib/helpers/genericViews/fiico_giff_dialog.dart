import 'package:cached_network_image/cached_network_image.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class FiicoGiffAlertDialog {
  static void show({
    required BuildContext context,
    required String urlImage,
    required String title,
    required String desc,
    required String okBtnText,
    required VoidCallback voidCallback,
  }) {
    showDialog(
      context: context,
      builder: (_) => NetworkGiffyDialog(
        image: CachedNetworkImage(
          imageUrl: urlImage,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: Style.title,
          textAlign: TextAlign.center,
        ),
        description: Text(
          desc,
          style: Style.subtitle,
          textAlign: TextAlign.center,
          maxLines: FiicoMaxLines.four,
        ),
        buttonOkText: Text(
          okBtnText,
          style: Style.subtitle.copyWith(
            color: FiicoColors.white,
          ),
        ),
        onOkButtonPressed: () => voidCallback.call(),
      ),
    );
  }
}
