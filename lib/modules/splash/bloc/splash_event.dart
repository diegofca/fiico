part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class SplashUserRequest extends SplashEvent {
  const SplashUserRequest();

  @override
  List<Object> get props => [];
}
