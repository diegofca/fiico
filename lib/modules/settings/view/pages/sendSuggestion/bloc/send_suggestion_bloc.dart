import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/model/suggestion.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/repository/send_suggestion_repository.dart';
import 'package:equatable/equatable.dart';

part 'send_suggestion_event.dart';
part 'send_suggestion_state.dart';

class SendSuggestionBloc extends Bloc<SendSuggetionEvent, SendSuggestionState> {
  SendSuggestionBloc(this.repository) : super(const SendSuggestionState()) {
    on<SendSuggetionRequest>(_mapSendSuggestionRequestToState);
    on<SendSuggestionUpdateTexRequest>(_mapSendUpdateSuggestionTextToState);
  }

  final SendSuggestionRepository repository;

  void _mapSendSuggestionRequestToState(
    SendSuggetionRequest event,
    Emitter<SendSuggestionState> emit,
  ) async {
    emit(state.copyWith(status: SendSuggestionStatus.loading));

    final user = await Preferences.get.getUser();
    await repository.sendSuggestion(user, state.suggestion);
    emit(state.copyWith(
      status: SendSuggestionStatus.success,
      sendSuggestion: true,
    ));
  }

  void _mapSendUpdateSuggestionTextToState(
    SendSuggestionUpdateTexRequest event,
    Emitter<SendSuggestionState> emit,
  ) async {
    emit(state.copyWith(
      status: SendSuggestionStatus.success,
      suggestion: event.suggestion,
    ));
  }
}
