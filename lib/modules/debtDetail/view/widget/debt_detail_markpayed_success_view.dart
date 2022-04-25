// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class MovementDetailMarkPayedSuccessBottomView {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: EdgeInsets.only(
                left: FiicoPaddings.eight,
                right: FiicoPaddings.eight,
                top: FiicoPaddings.sixteen,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(FiicoPaddings.twenyFour),
                  topRight: Radius.circular(FiicoPaddings.twenyFour),
                ),
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 200,
                  child: _animationPayedView(),
                ),
              ),
            );
          },
        );
      },
    );

    Timer(const Duration(milliseconds: 4500), () {
      Navigator.of(context).pop();
    });
  }

  static Widget _animationPayedView() {
    final image = Image.asset(
      GIFmages.markPayment,
      gaplessPlayback: false,
    );
    image.image.evict();
    return Padding(
      padding: EdgeInsets.zero,
      child: image,
    );
  }
}
