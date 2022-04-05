import 'package:control/helpers/extension/colors.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/profile/view/profile_app_bar.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:control/modules/profile/view/profile_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: ProfileAppBar(user: user),
      body: BlocProvider(
        create: (context) => MenuBloc(),
        child: const ProfilePageView(),
      ),
    );
  }
}

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        switch (state.status) {
          case MenuStatus.success:
            return ProfileSuccessView();
        }
      },
    );
  }
}
