part of 'send_suggestion_bloc.dart';

enum SendSuggestionStatus { success, loading }

class SendSuggestionState extends Equatable {
  const SendSuggestionState({
    this.status = SendSuggestionStatus.success,
    this.sendSuggestion,
    this.text,
  });

  final SendSuggestionStatus status;
  final String? text;
  final bool? sendSuggestion;

  bool get isSendSuggestion => sendSuggestion ?? false;

  @override
  List<Object?> get props => [status, text, sendSuggestion];

  SendSuggestionState copyWith({
    SendSuggestionStatus? status,
    String? text,
    bool? sendSuggestion,
  }) {
    return SendSuggestionState(
      status: status ?? this.status,
      text: text ?? this.text,
      sendSuggestion: sendSuggestion,
    );
  }
}
