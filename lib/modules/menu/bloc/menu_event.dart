part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class MenuIndexSelected extends MenuEvent {
  const MenuIndexSelected({
    this.index = 0,
  });

  final int index;

  @override
  List<Object?> get props => [index];
}
