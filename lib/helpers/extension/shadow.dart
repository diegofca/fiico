import 'package:flutter/material.dart';
import 'colors.dart';

extension FiicoShadow on BoxShadow {
  static var cardShadow = BoxShadow(
    color: FiicoColors.grayShadow,
    blurRadius: 20,
    spreadRadius: 5,
    offset: const Offset(0, 20),
  );

  static var centerShadow = const BoxShadow(
    color: FiicoColors.graySoft,
    blurRadius: 10,
    spreadRadius: 5,
    offset: Offset(0, 0),
  );
}
