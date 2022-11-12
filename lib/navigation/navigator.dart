// ignore_for_file: implementation_imports

import 'package:control/helpers/manager/analytics_manager.dart';
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
    AnalyticsManager().screenView(page.toString());
    return Navigator.pushReplacement(context, FiicoRouteTransitions.fade(page));
  }

  static Future<dynamic> send(BuildContext context, Widget page) {
    AnalyticsManager().screenView(page.toString());
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static Future<dynamic> present(BuildContext context, Widget page) {
    AnalyticsManager().screenView(page.toString());
    return Navigator.push(context, FiicoRouteTransitions.present(page));
  }

  static Future<dynamic> sendReplace(BuildContext context, Widget page) {
    AnalyticsManager().screenView(page.toString());
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void back(BuildContext context) {
    AnalyticsManager().backView();
    return Navigator.pop(context);
  }

  static void changeTab(BuildContext context, TabOption tabOption) {
    var tabIndex = tabOption.index;
    context.read<MenuBloc>().add(MenuIndexSelected(index: tabIndex));
    AnalyticsManager().screenView(tabOption.toString());
  }

  static void showLoader(BuildContext context) {
    context.loaderOverlay.show();
  }

  static void hideLoader(BuildContext context) {
    context.loaderOverlay.hide();
  }
}

// Route transitions
class FiicoRouteTransitions {
  static present(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        var tween = Tween(begin: begin, end: Offset.zero).chain(
          CurveTween(curve: Curves.ease),
        );
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (c, anim, a2, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(seconds: 1),
    );
  }
}
