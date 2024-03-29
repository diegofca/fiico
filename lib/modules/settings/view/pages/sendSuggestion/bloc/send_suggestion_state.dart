part of 'send_suggestion_bloc.dart';

enum SendSuggestionStatus { success, loading }

class SendSuggestionState extends Equatable {
  const SendSuggestionState({
    this.status = SendSuggestionStatus.success,
    this.sendSuggestion,
    this.suggestion,
  });

  final SendSuggestionStatus status;
  final Suggestion? suggestion;
  final bool? sendSuggestion;

  bool get isSendSuggestion => sendSuggestion ?? false;

  @override
  List<Object?> get props => [status, suggestion, sendSuggestion];

  SendSuggestionState copyWith({
    SendSuggestionStatus? status,
    Suggestion? suggestion,
    bool? sendSuggestion,
  }) {
    return SendSuggestionState(
      status: status ?? this.status,
      suggestion: suggestion ?? this.suggestion,
      sendSuggestion: sendSuggestion,
    );
  }
}
