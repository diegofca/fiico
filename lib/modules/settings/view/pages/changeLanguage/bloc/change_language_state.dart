part of 'change_language_bloc.dart';

enum ChangeLanguageStatus { init, loading }

class ChangeLanguageState extends Equatable {
  const ChangeLanguageState({
    this.status = ChangeLanguageStatus.init,
    this.language,
  });

  final ChangeLanguageStatus status;
  final Language? language;

  bool get isSelectedLanguage => language != null;

  @override
  List<Object?> get props => [status, language, isSelectedLanguage];

  ChangeLanguageState copyWith({
    ChangeLanguageStatus? status,
    Language? language,
  }) {
    return ChangeLanguageState(
      status: status ?? this.status,
      language: language,
    );
  }
}
