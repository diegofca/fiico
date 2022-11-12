import 'package:cached_network_image/cached_network_image.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FiicoImageNetwork extends StatelessWidget {
  final String? url;
  final double? size;
  final IconData? iconData;
  final Color? iconColor;

  const FiicoImageNetwork({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData,
    this.iconColor = FiicoColors.grayDark,
  }) : super(key: key);

  /// Movement image
  const FiicoImageNetwork.debt({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.arrowDownBold,
    this.iconColor = FiicoColors.grayDark,
  }) : super(key: key);

  /// Movement image
  const FiicoImageNetwork.entry({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.arrowUpBold,
    this.iconColor = FiicoColors.grayDark,
  }) : super(key: key);

  /// Budget image
  const FiicoImageNetwork.budget({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.sack,
    this.iconColor = FiicoColors.grayDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url?.isUrl() ?? false) {
      return CachedNetworkImage(
        imageUrl: url!,
        height: size,
        width: size,
        fit: BoxFit.cover,
      );
    }
    return Icon(
      iconData ?? MdiIcons.sack,
      size: size,
      color: iconColor,
    );
  }
}
