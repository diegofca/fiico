import 'package:control/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'bottom_nav_bar/bottom_nav.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({
    Key? key,
    this.selectIndex = 0,
  }) : super(key: key);

  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    final _tabs = _onCreateTabs(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Expanded(
          child: _ScreensView(
            screens: _tabs.map((e) => e.screen).toList(),
            selectedIndex: selectIndex,
          ),
        ),
        NavigationBottom(
          selectedIndex: selectIndex,
          onTabChange: (index) => _tabChanged(context, index),
          tabs: _tabs,
        )
      ],
    );
  }

  List<BottomNavBarItem> _onCreateTabs(BuildContext context) {
    // final l10n = context.l10n;

    return <BottomNavBarItem>[
      const BottomNavBarItem(
        icon: MdiIcons.homeVariant,
        text: "Home",
        screen: HomePage(
          key: Key('_MenuBottomTab.feedScreen'),
        ),
      ),
      const BottomNavBarItem(
        icon: MdiIcons.tableSettings,
        text: "Grupos",
        screen: Text(
          'Index 2',
        ),
      ),
      const BottomNavBarItem(
        icon: MdiIcons.bell,
        text: "Notificaciones",
        screen: Text(
          'Index 2',
        ),
      ),
      const BottomNavBarItem(
        icon: Icons.settings,
        text: "Configuración",
        screen: Text(
          'Index 2',
        ),
      ),
    ];
  }

  void _tabChanged(BuildContext context, int index) {
    // context.read<MenuBloc>().add(MenuIndexSelected(index: index));
  }
}

class _ScreensView extends StatelessWidget {
  const _ScreensView({
    Key? key,
    required this.screens,
    required this.selectedIndex,
  }) : super(key: key);

  final List<Widget> screens;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(screens.length, _buildTab),
    );
  }

  Widget _buildTab(int index) {
    return Offstage(
      offstage: selectedIndex != index,
      child: screens[index],
    );
  }
}
