part of 'change_language_bloc.dart';

abstract class ChangeLanguageEvent extends Equatable {
  const ChangeLanguageEvent();
}

class ChangeLanguagerRequest extends ChangeLanguageEvent {
  const ChangeLanguagerRequest({required this.language});

  final Language? language;

  @override
  List<Object?> get props => [language];
}

class BiometricIDEnableRequest extends ChangeLanguageEvent {
  const BiometricIDEnableRequest({required this.isEnable});

  final bool? isEnable;

  @override
  List<Object?> get props => [isEnable];
}
