import 'dart:math' show pow;
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class BottomNavBarButton extends StatefulWidget {
  const BottomNavBarButton({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.curve,
    required this.active,
  }) : super(key: key);

  final IconData? icon;
  final Text? text;
  final bool? active;
  final VoidCallback onPressed;
  final Curve? curve;

  @override
  _BottomNavBarButtonState createState() => _BottomNavBarButtonState();
}

class _BottomNavBarButtonState extends State<BottomNavBarButton>
    with TickerProviderStateMixin {
  late bool _expanded;
  late final AnimationController expandController;

  final animatedDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _expanded = widget.active!;
    expandController =
        AnimationController(vsync: this, duration: animatedDuration)
          ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final curveValue = expandController
        .drive(CurveTween(
            curve: _expanded ? widget.curve! : widget.curve!.flipped))
        .value;

    final _colorTween =
        ColorTween(begin: FiicoColors.graySoft, end: FiicoColors.purpleDark);
    final _colorTweenAnimation = _colorTween.animate(CurvedAnimation(
        parent: expandController,
        curve: _expanded ? Curves.easeInExpo : Curves.easeOutCirc));

    setExpandedAnimationState();

    final icon = Icon(
      widget.icon,
      color: _colorTweenAnimation.value,
      size: 22,
    );

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: widget.onPressed,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: FiicoPaddings.twenty,
          ),
          child: AnimatedContainer(
            curve: Curves.easeOut,
            duration: animatedDuration,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Builder(
                builder: (_) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: FiicoColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(FiicoPaddings.eight),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(FiicoPaddings.four),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                opacity: 0,
                                child: icon,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                widthFactor: curveValue,
                                child: Opacity(
                                  opacity: _opacityValue(),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: _leftPadding(),
                                      right: _rigthPadding(),
                                    ),
                                    child: widget.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(alignment: Alignment.centerLeft, child: icon),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _opacityValue() {
    final expandedValue =
        expandController.drive(CurveTween(curve: Curves.easeIn)).value;
    return _expanded
        ? pow(expandController.value, 13) as double
        : expandedValue;
  }

  double _leftPadding() {
    final expandedValue =
        expandController.drive(CurveTween(curve: Curves.easeOutSine)).value;
    return 18 - (10 * expandedValue);
  }

  double _rigthPadding() {
    final expandedValue =
        expandController.drive(CurveTween(curve: Curves.easeOutSine)).value;
    return (10 * expandedValue);
  }

  void setExpandedAnimationState() {
    _expanded = !widget.active!;
    if (_expanded) {
      expandController.reverse();
    } else {
      expandController.forward();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }
}
