import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FiicoToast {
  static void showInfoToast() {}

  static void showWarningToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: FiicoColors.pinkRed,
      textColor: FiicoColors.white,
      fontSize: FiicoFontSize.xm,
    );
  }
}
