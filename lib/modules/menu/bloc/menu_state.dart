part of 'menu_bloc.dart';

enum MenuStatus {
  success,
}

class MenuState extends Equatable {
  const MenuState({
    this.status = MenuStatus.success,
    this.selectedIndex = 0,
  });

  final MenuStatus status;
  final int selectedIndex;

  @override
  List<Object> get props => [status, selectedIndex];

  MenuState copyWith({
    MenuStatus? status,
    int? selectedIndex,
  }) {
    return MenuState(
      status: status ?? this.status,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
