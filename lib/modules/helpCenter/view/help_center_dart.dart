// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/editProfile/bloc/edit_profile_bloc.dart';
import 'package:control/modules/editProfile/repository/edit_profile_repository.dart';
import 'package:control/modules/helpCenter/view/help_center_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpCenterPage extends StatelessWidget {
  HelpCenterPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: const GenericAppBar(
        text: 'Help center',
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => EditProfileBloc(EditProfileRepository())
          ..add(EditProfileInitDataRequest(user: user)),
        child: HelpCenterView(user: user),
      ),
    );
  }
}

class HelpCenterView extends StatelessWidget {
  HelpCenterView({
    Key? key,
    required this.user,
  }) : super(key: key);

  FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return HelpCenterSuccessView(user: user);
      },
      listener: (context, state) {
        if (state.onUpdateComplete) {
          user = state.user;
        }
      },
    );
  }
}
