part of 'send_suggestion_bloc.dart';

abstract class SendSuggetionEvent extends Equatable {
  const SendSuggetionEvent();
}

class SendSuggetionRequest extends SendSuggetionEvent {
  const SendSuggetionRequest();

  @override
  List<Object?> get props => [];
}

class SendSuggestionUpdateTexRequest extends SendSuggetionEvent {
  const SendSuggestionUpdateTexRequest({required this.suggestion});

  final Suggestion? suggestion;

  @override
  List<Object?> get props => [suggestion];
}
