import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
    this.backgroundColor = FiicoColors.purpleDark,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        color: backgroundColor.withOpacity(0.5),
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.white,
                    backgroundColor: FiicoColors.purpleDark,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FiicoColors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
