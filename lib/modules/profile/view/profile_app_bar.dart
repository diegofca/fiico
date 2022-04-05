import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/profile_image.dart';
import 'package:control/models/user.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileAppBar extends StatelessWidget with PreferredSizeWidget {
  const ProfileAppBar({
    Key? key,
    required this.user,
    this.leading,
    this.actions,
  }) : super(key: key);

  final Widget? leading;
  final List<Widget>? actions;
  final FiicoUser? user;

  //añadir un user como parametro
  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      backgroundColor: FiicoColors.purpleDark,
      leading: leading,
      actions: actions ?? [],
      bottom: bottomWidget,
      elevation: 0,
    );
  }

  Widget get bottom => SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileImage(size: 70),
            Padding(
              padding: const EdgeInsets.only(top: FiicoPaddings.four),
              child: Text(
                user?.firstName ?? '',
                style: Style.title.copyWith(
                  color: FiicoColors.white,
                ),
              ),
            ),
            Text(
              user?.email ?? '',
              style: Style.subtitle.copyWith(
                color: FiicoColors.white,
                fontWeight: FiicoFontWeight.regular,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: FiicoPaddings.sixtyTwo,
                vertical: FiicoPaddings.sixteen,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: FiicoPaddings.twenyFour,
                vertical: FiicoPaddings.four,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  FiicoPaddings.sixteen,
                ),
                color: FiicoColors.purpleNeutral,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    MdiIcons.crown,
                    color: FiicoColors.gold,
                  ),
                  Text(
                    "Plan Premium",
                    style: Style.desc.copyWith(
                      color: FiicoColors.white,
                      fontSize: FiicoFontSize.xxs,
                    ),
                  ),
                  Text(
                    "-",
                    style: Style.desc.copyWith(
                      color: FiicoColors.white,
                    ),
                  ),
                  Text(
                    "20 de abril ",
                    style: Style.desc.copyWith(
                      color: FiicoColors.white,
                      fontSize: FiicoFontSize.xxs,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  PreferredSizeWidget? get bottomWidget => PreferredSize(
        preferredSize: preferredSize,
        child: bottom,
      );

  @override
  Size get preferredSize => const Size.fromHeight(220);
}
