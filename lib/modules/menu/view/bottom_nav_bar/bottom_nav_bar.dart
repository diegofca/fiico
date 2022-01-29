import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_bar_item.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({
    Key? key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
    this.curve = Curves.easeInCubic,
  }) : super(key: key);

  final List<BottomNavBarItem> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;
  final Curve curve;

  static double height = 60.0;

  @override
  _NavigationBottomState createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(NavigationBottom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: FiicoColors.grayNeutral.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 20,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.tabs
                  .map(
                    (t) => BottomNavBarItem(
                      key: t.key,
                      text: t.text,
                      icon: t.icon,
                      curve: widget.curve,
                      screen: t.screen,
                      active: selectedIndex == widget.tabs.indexOf(t),
                      onPressed: () => _onPressed(t),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed(BottomNavBarItem item) {
    selectedIndex = widget.tabs.indexOf(item);
    item.onPressed?.call();
    widget.onTabChange?.call(selectedIndex);
  }
}
