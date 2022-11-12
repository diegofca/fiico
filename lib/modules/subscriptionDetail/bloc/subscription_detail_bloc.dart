import 'package:bloc/bloc.dart';
import 'package:control/models/plan.dart';
import 'package:equatable/equatable.dart';

part 'subscription_detail_event.dart';
part 'subscription_detail_state.dart';

class SubscriptionDetailBloc
    extends Bloc<SubscriptionDetailEvent, SubscriptionDetailState> {
  SubscriptionDetailBloc() : super(const SubscriptionDetailState()) {
    on<UpdateSubscriptionDetail>(_mapUpdateSubscriptionDetail);
  }

  void _mapUpdateSubscriptionDetail(
    UpdateSubscriptionDetail event,
    Emitter<SubscriptionDetailState> emit,
  ) {
    emit(state.copyWith(status: SubscriptionDetailStatus.loading));
    emit(state.copyWith(
      status: SubscriptionDetailStatus.init,
      plan: event.newPlan,
    ));
  }
}
