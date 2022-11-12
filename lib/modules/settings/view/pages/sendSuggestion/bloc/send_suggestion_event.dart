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
  const SendSuggestionUpdateTexRequest({required this.text});

  final String? text;

  @override
  List<Object?> get props => [text];
}
