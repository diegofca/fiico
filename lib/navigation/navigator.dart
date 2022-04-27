// ignore_for_file: implementation_imports

import 'package:control/modules/menu/bloc/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:provider/src/provider.dart';

enum TabOption {
  home,
  budgets,
  notifications,
  profile,
}

extension FiicoRoute on Navigator {
  static Future<dynamic> sendFade(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(seconds: 1),
      ),
    );
  }

  static Future<dynamic> send(BuildContext context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static Future<dynamic> sendReplace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void changeTab(BuildContext context, TabOption tabOption) {
    var tabIndex = tabOption.index;
    context.read<MenuBloc>().add(MenuIndexSelected(index: tabIndex));
  }

  static void showLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  static void hideLoader(BuildContext context) {
    context.loaderOverlay.hide();
  }
}
