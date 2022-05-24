part of 'help_center_bloc.dart';

enum HelpCenterStatus { init, loading }

class HelpCenterState extends Equatable {
  const HelpCenterState({
    this.status = HelpCenterStatus.init,
    this.conversation,
    this.conversationID,
    this.messages,
  });

  final HelpCenterStatus status;
  final String? conversationID;
  final Stream<List<HelpCenterConversation>>? conversation;
  final Stream<List<HelpCenterMessage>>? messages;

  bool get isloadConversation => conversationID != null;
  bool get haveConversation => conversation != null;

  @override
  List<Object?> get props => [status, conversation, messages, conversationID];

  HelpCenterState copyWith({
    HelpCenterStatus? status,
    Stream<List<HelpCenterConversation>>? conversation,
    Stream<List<HelpCenterMessage>>? messages,
    String? conversationID,
  }) {
    return HelpCenterState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      conversationID: conversationID ?? this.conversationID,
      messages: messages ?? this.messages,
    );
  }
}
