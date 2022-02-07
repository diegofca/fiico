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

class FiicoTabsOption {
  static final Map<String, int> options = {
    TabOption.home.name: 1,
  };
}

extension FiicoRoute on Navigator {
  static Future<dynamic> send(BuildContext context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void changeTab(BuildContext context, TabOption tabOption) {
    var tabIndex = tabOption.index;
    // switch (tabOption) {
    //   case TabOption.budgets:
    //     tabIndex = 0;
    //     break;
    //   case TabOption.home:
    //     tabIndex = 1;
    //     break;
    //   case TabOption.notifications:
    //     tabIndex = 2;
    //     break;
    //   case TabOption.profile:
    //     tabIndex = 3;
    //     break;
    // }

    context.read<MenuBloc>().add(MenuIndexSelected(index: tabIndex));
  }
}
