import 'package:control/models/user.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:control/modules/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_bar/bottom_nav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuSuccessView extends StatelessWidget {
  const MenuSuccessView({
    Key? key,
    this.selectIndex = 0,
    this.user,
  }) : super(key: key);

  final int selectIndex;
  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    final _tabs = onCreateTabs(user, context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: NavigationBottom.height - 10,
            ),
            child: _TabScreensView(
              screens: _tabs.map((e) => e.screen).toList(),
              selectedIndex: selectIndex,
            ),
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

  void _tabChanged(BuildContext context, int index) {
    context.read<MenuBloc>().add(MenuIndexSelected(index: index));
  }
}

class _TabScreensView extends StatelessWidget {
  const _TabScreensView({
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
