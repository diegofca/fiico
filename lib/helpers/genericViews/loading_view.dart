import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        color: FiicoColors.black.withOpacity(0.8),
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
