import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/change_language_repository.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:equatable/equatable.dart';

part 'change_language_event.dart';
part 'change_language_state.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc(this.repository) : super(const ChangeLanguageState()) {
    on<ChangeLanguagerRequest>(_mapUpdateLanguageToState);
  }

  final ChangeLanguageRepository repository;

  void _mapUpdateLanguageToState(
    ChangeLanguagerRequest event,
    Emitter<ChangeLanguageState> emit,
  ) async {
    emit(state.copyWith(status: ChangeLanguageStatus.loading, language: null));
    final user = await Preferences.get.getUser();
    if (user != null) {
      await repository.updateLanguageUser(
        user,
        event.language?.locale.languageCode,
      );
    }
    emit(state.copyWith(
      status: ChangeLanguageStatus.init,
      language: event.language,
    ));
  }
}
