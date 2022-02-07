import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuState()) {
    on<MenuIndexSelected>(
      _mapProductsCatalogLayoutChangeToState,
    );
  }

  void _mapProductsCatalogLayoutChangeToState(
    MenuIndexSelected event,
    Emitter<MenuState> emit,
  ) {
    emit(state.copyWith(
      status: MenuStatus.success,
      selectedIndex: event.index,
    ));
  }
}
