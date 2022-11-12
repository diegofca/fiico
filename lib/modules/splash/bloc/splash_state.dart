// ignore_for_file: must_be_immutable

part of 'splash_bloc.dart';

enum SplashStatus { success, loading, failure }

class SplashState extends Equatable {
  const SplashState({
    this.status = SplashStatus.success,
    this.user,
  });

  final SplashStatus status;
  final FiicoUser? user;

  bool get isLogged => user != null;

  @override
  List<Object?> get props => [status, user];

  SplashState copyWith({
    SplashStatus? status,
    FiicoUser? user,
  }) {
    return SplashState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
