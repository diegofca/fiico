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

  const FiicoImageNetwork.movement({
    Key? key,
    this.url,
    this.size = 40,
    this.iconData = MdiIcons.arrowUpBold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null && url!.isNotEmpty) {
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
