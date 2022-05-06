import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

class FiicoToast {
  static late OverlaySupportEntry overlay;

  static void showInfoToast() {}

  static void showWarningToast(String message) {
    toast('Hello world!');

    showSimpleNotification(
      Text(message),
      background: Colors.green,
    );
  }

  static void showPushNotificationClicked(
    RemoteMessage message, {
    required VoidCallback onTap,
  }) {
    HapticFeedback.vibrate();
    overlay = showSimpleNotification(
      GestureDetector(
        onTap: () {
          onTap.call();
          overlay.dismiss();
        },
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message.notification?.body ?? '',
                    style: Style.subtitle.copyWith(
                      color: FiicoColors.grayDark,
                      fontSize: FiicoFontSize.xm,
                    ),
                    maxLines: FiicoMaxLines.ten,
                  ),
                ),
                const Icon(
                  Icons.double_arrow_rounded,
                  color: FiicoColors.purpleDark,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
      elevation: 20,
      background: FiicoColors.white,
      position: NotificationPosition.bottom,
      slideDismissDirection: DismissDirection.down,
      autoDismiss: false,
    );
  }

  static void showLocalNotification(
    RemoteMessage message, {
    required VoidCallback onTap,
  }) {
    HapticFeedback.vibrate();
    overlay = showSimpleNotification(
      GestureDetector(
        onTap: () {
          onTap.call();
          overlay.dismiss();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 24,
                  left: 8,
                ),
                child: Icon(
                  Icons.cloud,
                  color: FiicoColors.white,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        message.notification?.title ?? '',
                        style: Style.title.copyWith(color: FiicoColors.white),
                        maxLines: FiicoMaxLines.two,
                      ),
                    ),
                    Text(
                      message.notification?.body ?? '',
                      style: Style.subtitle.copyWith(color: FiicoColors.white),
                      maxLines: FiicoMaxLines.four,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      background: FiicoColors.purpleNeutral,
      position: NotificationPosition.top,
      slideDismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 5),
    );
  }
}
