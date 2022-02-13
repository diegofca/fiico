import 'package:control/helpers/extension/string.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FiicoImageNetwork extends StatelessWidget {
  final String? url;
  final double? size;
  final IconData? iconData;

  const FiicoImageNetwork({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData,
  }) : super(key: key);

  /// Movement image
  const FiicoImageNetwork.debt({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.arrowDownBold,
  }) : super(key: key);

  /// Movement image
  const FiicoImageNetwork.entry({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.arrowUpBold,
  }) : super(key: key);

  /// Budget image
  const FiicoImageNetwork.budget({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.sack,
  }) : super(key: key);

  /// Budget image
  const FiicoImageNetwork.user({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.faceManShimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url?.isUrl() ?? false) {
      return Image.network(
        url!,
        height: size,
        width: size,
        fit: BoxFit.cover,
      );
    }
    return Icon(
      iconData ?? MdiIcons.sack,
      size: size,
    );
  }
}
