import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityInitial());
}
