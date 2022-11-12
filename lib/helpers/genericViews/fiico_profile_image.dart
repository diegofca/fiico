import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FiicoProfileNetwork extends StatelessWidget {
  final String? url;
  final double? size;
  final IconData? iconData;

  const FiicoProfileNetwork({
    Key? key,
    this.url,
    this.size = 30,
    this.iconData,
  }) : super(key: key);

  /// Budget image
  const FiicoProfileNetwork.user({
    Key? key,
    this.url,
    this.size = 30,
    this.iconData = MdiIcons.faceManShimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url?.isUrl() ?? false) {
      return CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(
          url!,
          scale: size ?? 30,
        ),
        backgroundColor: Colors.transparent,
      );
    }

    return CircleAvatar(
      backgroundColor: FiicoColors.grayShadow,
      child: Icon(
        iconData ?? MdiIcons.sack,
        color: FiicoColors.black,
        size: size,
      ),
    );
  }
}
