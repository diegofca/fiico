// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/editProfile/bloc/edit_profile_bloc.dart';
import 'package:control/modules/editProfile/repository/edit_profile_repository.dart';
import 'package:control/modules/editProfile/view/edit_profile_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().editUser,
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => EditProfileBloc(EditProfileRepository())
          ..add(EditProfileInitDataRequest(user: user)),
        child: EditProfilePageView(user: user),
      ),
    );
  }
}

class EditProfilePageView extends StatelessWidget {
  EditProfilePageView({
    Key? key,
    required this.user,
  }) : super(key: key);

  FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return EditProfileSuccessView(user: user);
      },
      listener: (context, state) {
        if (state.onUpdateComplete) {
          user = state.user;
        }
      },
    );
  }
}
