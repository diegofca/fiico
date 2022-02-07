import 'package:control/modules/budgets/view/budgets_page.dart';
import 'package:control/modules/home/home.dart';
import 'package:control/modules/notifications/view/notifications_page.dart';
import 'package:control/modules/profile/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'view/bottom_nav_bar/bottom_nav.dart';

List<BottomNavBarItem> onCreateTabs(BuildContext context) {
  // final l10n = context.l10n;

  return <BottomNavBarItem>[
    BottomNavBarItem(
      icon: MdiIcons.homeVariant,
      screen: HomePage(
        key: const Key('_MenuHome.home'),
      ),
    ),
    const BottomNavBarItem(
      icon: MdiIcons.tableSettings,
      screen: BudgetsPage(
        key: Key('_MenuHome.budgets'),
      ),
    ),
    const BottomNavBarItem(
      icon: MdiIcons.bell,
      screen: NotificationsPage(
        key: Key('_MenuHome.notifications'),
      ),
    ),
    const BottomNavBarItem(
      icon: Icons.settings,
      screen: ProfilePage(
        key: Key('_MenuHome.profile'),
      ),
    ),
  ];
}
