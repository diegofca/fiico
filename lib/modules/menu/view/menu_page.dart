import 'package:control/models/user.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'menu_success_view.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(),
      child: MenuPageView(user: user),
    );
  }
}

class MenuPageView extends StatelessWidget {
  const MenuPageView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        switch (state.status) {
          case MenuStatus.success:
            return MenuSuccessView(
              selectIndex: state.selectedIndex,
              user: user,
            );
        }
      },
    );
  }
}
