// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/invite_friend.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/friends/bloc/friends_bloc.dart';
import 'package:control/modules/friends/repository/friends_repository.dart';
import 'package:control/modules/friends/view/friends_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().friends,
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => FriendsBloc(FriendsRepository())
          ..add(InvitationsListFetchRequest(uID: user?.id))
          ..add(FriendsListFetchRequest(uID: user?.id)),
        child: FriendsPageView(),
      ),
    );
  }
}

class FriendsPageView extends StatelessWidget {
  FriendsPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendState>(
      builder: (context, state) {
        switch (state.status) {
          default:
            return StreamBuilder<List<InviteFriend>>(
              stream: state.invitations,
              builder: (context, snapshot) {
                return StreamBuilder<List<FiicoUser>>(
                  stream: state.friends,
                  builder: (context, fSnapshot) {
                    if (snapshot.hasData && fSnapshot.hasData) {
                      return FriendsSuccessView(
                        invitations: snapshot.data ?? [],
                        friends: fSnapshot.data ?? [],
                      );
                    }
                    return const LoadingView(
                      backgroundColor: FiicoColors.white,
                    );
                  },
                );
              },
            );
        }
      },
    );
  }
}
