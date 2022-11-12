import 'package:bloc/bloc.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/splash/repository/splash_repository.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';
part 'splash_event.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this.repository) : super(const SplashState()) {
    on<SplashUserRequest>(_mapUserToState);
  }

  final SplashRepository repository;

  void _mapUserToState(
    SplashUserRequest event,
    Emitter<SplashState> emit,
  ) async {
    final user = await repository.getUserTolocalState();
    emit(state.copyWith(
      status: SplashStatus.success,
      user: user,
    ));
  }
}
