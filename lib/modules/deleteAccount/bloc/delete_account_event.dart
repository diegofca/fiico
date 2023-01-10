part of 'delete_account_bloc.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();
}

class SendSuggetionRequest extends DeleteAccountEvent {
  const SendSuggetionRequest();

  @override
  List<Object?> get props => [];
}

class SendSuggestionUpdateRequest extends DeleteAccountEvent {
  const SendSuggestionUpdateRequest({required this.suggestion});

  final Suggestion? suggestion;

  @override
  List<Object?> get props => [suggestion];
}

class CancelSuggestionRequest extends DeleteAccountEvent {
  const CancelSuggestionRequest({required this.suggestion});

  final Suggestion? suggestion;

  @override
  List<Object?> get props => [suggestion];
}

class IsPendingRemoveAccountRequest extends DeleteAccountEvent {
  const IsPendingRemoveAccountRequest();

  @override
  List<Object?> get props => [];
}
