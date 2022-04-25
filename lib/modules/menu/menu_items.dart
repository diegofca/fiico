import 'package:control/models/user.dart';
import 'package:control/modules/budgets/view/budgets_page.dart';
import 'package:control/modules/home/home.dart';
import 'package:control/modules/notifications/view/notifications_page.dart';
import 'package:control/modules/profile/view/profile_page.dart';
import 'package:control/modules/settings/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'view/bottom_nav_bar/bottom_nav.dart';

List<BottomNavBarItem> onCreateTabs(FiicoUser? user, BuildContext context) {
  return <BottomNavBarItem>[
    BottomNavBarItem(
      icon: MdiIcons.homeVariant,
      screen: HomePage(
        key: const Key('_MenuHome.home'),
        user: user,
      ),
    ),
    BottomNavBarItem(
      icon: MdiIcons.tableSettings,
      screen: BudgetsPage(
        key: const Key('_MenuHome.budgets'),
        user: user,
      ),
    ),
    BottomNavBarItem(
      icon: MdiIcons.bell,
      badgeVisible: true,
      screen: NotificationsPage(
        key: const Key('_MenuHome.notifications'),
        user: user,
      ),
    ),
    BottomNavBarItem(
      icon: Icons.settings,
      screen: SettingsPage(
        key: const Key('_MenuHome.settings'),
        user: user,
      ),
    ),
  ];
}
