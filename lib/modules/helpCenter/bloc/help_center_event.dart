part of 'help_center_bloc.dart';

abstract class HelpCenterEvent extends Equatable {
  const HelpCenterEvent();
}

class HelpCenterConversationFetchRequest extends HelpCenterEvent {
  const HelpCenterConversationFetchRequest({required this.uID});

  final String? uID;

  @override
  List<Object?> get props => [uID];
}

class HelpCenterMessagesConversationFetchRequest extends HelpCenterEvent {
  const HelpCenterMessagesConversationFetchRequest({
    required this.uID,
    required this.conversationID,
  });

  final String? uID;
  final String? conversationID;

  @override
  List<Object?> get props => [uID, conversationID];
}

class HelpCenterNeMessageFetchRequest extends HelpCenterEvent {
  const HelpCenterNeMessageFetchRequest({required this.text});

  final String? text;

  @override
  List<Object?> get props => [text];
}
