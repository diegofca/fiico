import 'package:bloc/bloc.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/payment_history.dart';
import 'package:control/modules/premium/repository/premium_repository.dart';
import 'package:equatable/equatable.dart';

part 'premium_event.dart';
part 'premium_state.dart';

class PremiumBloc extends Bloc<PremiumEvent, PremiumState> {
  PremiumBloc(this.repository) : super(const PremiumState()) {
    on<PremiumCompletePurchase>(_mapIsEnableBiometricToState);
  }

  final PremiumRepository repository;

  void _mapIsEnableBiometricToState(
    PremiumCompletePurchase event,
    Emitter<PremiumState> emit,
  ) async {
    emit(state.copyWith(status: PremiumStatus.loading));
    final user = await Preferences.get.getUser();
    await repository.purchasePlanCompleted(user, event.paymentPremium);
    emit(state.copyWith(
      status: PremiumStatus.init,
      paymentPremium: event.paymentPremium,
    ));
  }
}
