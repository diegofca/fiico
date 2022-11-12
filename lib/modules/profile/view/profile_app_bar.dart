import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/profile_image.dart';
import 'package:control/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAppBar extends StatelessWidget with PreferredSizeWidget {
  const ProfileAppBar({
    Key? key,
    required this.user,
    this.leading,
    this.actions,
    this.onDetailTap,
  }) : super(key: key);

  final Widget? leading;
  final List<Widget>? actions;
  final FiicoUser? user;
  final VoidCallback? onDetailTap;

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
        height: 190,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileImage(user: user, size: 55),
            _getNameUser(),
            _getEmailUser(),
            _getPlanDetail()
          ],
        ),
      );

  Widget _getNameUser() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.eight,
      ),
      child: Text(
        user?.firstName ?? '',
        style: Style.title.copyWith(
          color: FiicoColors.white,
        ),
      ),
    );
  }

  Widget _getEmailUser() {
    return Text(
      user?.email ?? '',
      style: Style.subtitle.copyWith(
        color: FiicoColors.white,
        fontWeight: FiicoFontWeight.regular,
      ),
    );
  }

  Widget _getPlanDetail() {
    return GestureDetector(
      onTap: () => onDetailTap?.call(),
      child: Container(
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
            SvgPicture.asset(
              user?.currentPlan?.icon ?? '',
              color: user?.currentPlan?.getStatusIconColor(),
              width: 30,
              height: 20,
            ),
            Text(
              user?.currentPlan?.getPlanTitle() ?? '',
              style: Style.desc.copyWith(
                color: FiicoColors.white,
                fontSize: FiicoFontSize.xxs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget? get bottomWidget => PreferredSize(
        preferredSize: preferredSize,
        child: bottom,
      );

  @override
  Size get preferredSize => const Size.fromHeight(220);
}
