import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

class FiicoToast {
  static late OverlaySupportEntry overlay;

  static void showInfoToast(String message) {
    toast(message);
  }

  static void showNotificationAlert(
    String message, {
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
              top: FiicoPaddings.twenyFour,
              bottom: FiicoPaddings.twenyFour,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: Style.subtitle.copyWith(
                      color: FiicoColors.gold,
                      fontSize: FiicoFontSize.xm,
                    ),
                    maxLines: FiicoMaxLines.ten,
                  ),
                ),
                const Icon(
                  Icons.double_arrow_rounded,
                  color: FiicoColors.white,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
      elevation: 20,
      background: FiicoColors.purpleNeutral,
      position: NotificationPosition.top,
      slideDismissDirection: DismissDirection.up,
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
        child: Container(
          color: FiicoColors.purpleNeutral,
          padding: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.sixteen,
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: FiicoPaddings.twenyFour,
                  left: FiicoPaddings.eight,
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
                      padding: const EdgeInsets.only(
                        bottom: FiicoPaddings.eight,
                      ),
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
      duration: const Duration(seconds: 10),
    );
  }
}
