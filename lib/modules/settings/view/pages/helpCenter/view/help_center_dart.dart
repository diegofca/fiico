// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/helpCenterConversation.dart';
import 'package:control/models/helpCenterMessage.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/helpCenter/bloc/help_center_bloc.dart';
import 'package:control/modules/settings/view/pages/helpCenter/repository/help_center_repository.dart';
import 'package:control/modules/settings/view/pages/helpCenter/view/help_center_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

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
      appBar: GenericAppBar(
        text: FiicoLocale().helpCenter,
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => HelpCenterBloc(
          HelpCenterRepository(),
        )..add(HelpCenterConversationFetchRequest(uID: user?.id)),
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
    final bloc = context.read<HelpCenterBloc>();
    return BlocBuilder<HelpCenterBloc, HelpCenterState>(
      builder: (context, state) {
        return StreamBuilder<List<HelpCenterConversation>>(
          stream: state.conversation,
          builder: (context, snapshot) {
            switch (snapshot.hasData) {
              case true:
                HelpCenterConversation? conversation =
                    snapshot.data?.firstOrNull;
                if (state.haveConversation && !state.isloadConversation) {
                  bloc.add(HelpCenterMessagesConversationFetchRequest(
                    uID: user?.id,
                    conversationID: conversation?.id,
                  ));
                }
                return _messagesStream(state, conversation);
              default:
                return const LoadingView();
            }
          },
        );
      },
    );
  }

  Widget _messagesStream(
    HelpCenterState state,
    HelpCenterConversation? conversation,
  ) {
    return StreamBuilder<List<HelpCenterMessage>>(
      stream: state.messages,
      builder: (context, msgsSnapshot) {
        final _conversation = conversation?..addMessages(msgsSnapshot.data);
        return HelpCenterSuccessView(
          conversation: _conversation,
          user: user,
        );
      },
    );
  }
}
