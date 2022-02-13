// ignore_for_file: implementation_imports

import 'package:control/modules/menu/bloc/menu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

enum TabOption {
  home,
  budgets,
  notifications,
  profile,
}

extension FiicoRoute on Navigator {
  static Future<dynamic> send(BuildContext context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void changeTab(BuildContext context, TabOption tabOption) {
    var tabIndex = tabOption.index;
    context.read<MenuBloc>().add(MenuIndexSelected(index: tabIndex));
  }
}