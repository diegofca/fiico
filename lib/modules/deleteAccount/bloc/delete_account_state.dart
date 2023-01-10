part of 'delete_account_bloc.dart';

enum DeleteAccountStatus { success, loading, removePending }

class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.status = DeleteAccountStatus.loading,
    this.sendSuggestion,
    this.suggestion,
  });

  final DeleteAccountStatus status;
  final Suggestion? suggestion;
  final bool? sendSuggestion;

  bool get isSendSuggestion => sendSuggestion ?? false;

  @override
  List<Object?> get props => [status, suggestion, sendSuggestion];

  DeleteAccountState copyWith({
    DeleteAccountStatus? status,
    Suggestion? suggestion,
    bool? sendSuggestion,
  }) {
    return DeleteAccountState(
      status: status ?? this.status,
      suggestion: suggestion ?? this.suggestion,
      sendSuggestion: sendSuggestion,
    );
  }
}
