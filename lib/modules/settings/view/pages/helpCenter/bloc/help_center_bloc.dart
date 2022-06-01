import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/helpCenterConversation.dart';
import 'package:control/models/helpCenterMessage.dart';
import 'package:control/modules/settings/view/pages/helpCenter/repository/help_center_repository.dart';
import 'package:equatable/equatable.dart';

part 'help_center_event.dart';
part 'help_center_state.dart';

class HelpCenterBloc extends Bloc<HelpCenterEvent, HelpCenterState> {
  HelpCenterBloc(this.repository) : super(const HelpCenterState()) {
    on<HelpCenterConversationFetchRequest>(_mapConversationRequestToState);
    on<HelpCenterMessagesConversationFetchRequest>(
        _mapMesssagesConversationRequestToState);
    on<HelpCenterNeMessageFetchRequest>(_mapNewMesssageRequestToState);
  }

  final HelpCenterRepository repository;

  void _mapConversationRequestToState(
    HelpCenterConversationFetchRequest event,
    Emitter<HelpCenterState> emit,
  ) async {
    emit(state.copyWith(
      status: HelpCenterStatus.init,
      conversation: repository.conversation(event.uID),
    ));
  }

  void _mapMesssagesConversationRequestToState(
    HelpCenterMessagesConversationFetchRequest event,
    Emitter<HelpCenterState> emit,
  ) async {
    emit(state.copyWith(
      status: HelpCenterStatus.init,
      messages: repository.messsages(event.conversationID, event.uID),
      conversationID: event.conversationID,
    ));
  }

  void _mapNewMesssageRequestToState(
    HelpCenterNeMessageFetchRequest event,
    Emitter<HelpCenterState> emit,
  ) async {
    final message = HelpCenterMessage(
      message: event.text,
      createdAt: Timestamp.now(),
      isUserSender: true,
      type: HelpCenterMessage.textType,
    );

    final userID = Preferences.get.getID;
    await repository.newMessage(message, state.conversationID, userID);

    emit(state.copyWith(
      status: HelpCenterStatus.init,
    ));
  }
}
