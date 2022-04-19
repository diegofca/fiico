import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FiicoIcon {
  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;

  FiicoIcon({
    required this.codePoint,
    required this.fontFamily,
    required this.fontPackage,
  });

  const FiicoIcon.empty({
    this.codePoint = 986414,
    this.fontFamily = 'Material Design Icons',
    this.fontPackage = 'material_design_icons_flutter',
  });

  factory FiicoIcon.fromJson(Map<String, dynamic>? json) {
    return FiicoIcon(
      codePoint: json?['codePoint'] ?? MdiIcons.sack.codePoint,
      fontFamily: json?['fontFamily'] ?? MdiIcons.sack.fontFamily,
      fontPackage: json?['fontPackage'] ?? MdiIcons.sack.fontPackage,
    );
  }

  factory FiicoIcon.fromIcon(IconData? icon) {
    return FiicoIcon(
      codePoint: icon?.codePoint ?? MdiIcons.sack.codePoint,
      fontFamily: icon?.fontFamily ?? MdiIcons.sack.fontFamily,
      fontPackage: icon?.fontPackage ?? MdiIcons.sack.fontPackage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
    };
  }

  IconData getIcon() {
    return IconData(
      codePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );
  }
}
