import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subscription_detail_event.dart';
part 'subscription_detail_state.dart';

class SubscriptionDetailBloc
    extends Bloc<SubscriptionDetailEvent, SubscriptionDetailState> {
  SubscriptionDetailBloc() : super(SubscriptionDetailInitial()) {
    on<SubscriptionDetailEvent>((event, emit) {});
  }
}
