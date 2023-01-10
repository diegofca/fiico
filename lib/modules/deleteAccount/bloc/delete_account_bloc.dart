import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/model/suggestion.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/repository/send_suggestion_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc(this.repository) : super(const DeleteAccountState()) {
    on<SendSuggetionRequest>(_mapSendSuggestionRequestToState);
    on<SendSuggestionUpdateRequest>(_mapSendUpdateSuggestionTextToState);
    on<CancelSuggestionRequest>(_mapCancelSuggestionToState);
    on<IsPendingRemoveAccountRequest>(_mapIsPendingRemoveAccountToState);
  }

  final SendSuggestionRepository repository;

  void _mapSendSuggestionRequestToState(
    SendSuggetionRequest event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(state.copyWith(status: DeleteAccountStatus.loading));

    final user = await Preferences.get.getUser();
    await repository.sendSuggestion(user, state.suggestion);
    emit(state.copyWith(
      status: DeleteAccountStatus.removePending,
      sendSuggestion: true,
    ));
  }

  void _mapIsPendingRemoveAccountToState(
    IsPendingRemoveAccountRequest event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(state.copyWith(status: DeleteAccountStatus.loading));

    final user = await Preferences.get.getUser();
    final isRemovePending = await repository.isRemoveAccountPending(user);
    final suggestion = await repository.getSuggestions(user).first;

    emit(state.copyWith(
      status: isRemovePending
          ? DeleteAccountStatus.removePending
          : DeleteAccountStatus.success,
      suggestion: suggestion?.firstOrNull,
    ));
  }

  void _mapSendUpdateSuggestionTextToState(
    SendSuggestionUpdateRequest event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(state.copyWith(
      status: DeleteAccountStatus.success,
      suggestion: event.suggestion,
    ));
  }

  void _mapCancelSuggestionToState(
    CancelSuggestionRequest event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(state.copyWith(status: DeleteAccountStatus.loading));

    final user = await Preferences.get.getUser();
    await repository.deleteSuggestion(user, event.suggestion);

    emit(state.copyWith(
      status: DeleteAccountStatus.success,
      suggestion: null,
    ));
  }
}
