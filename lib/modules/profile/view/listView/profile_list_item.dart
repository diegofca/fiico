import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/profile/model/profile_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileListItemView extends StatefulWidget {
  const ProfileListItemView({
    Key? key,
    required this.option,
  }) : super(key: key);

  final ProfileOption option;

  @override
  State<ProfileListItemView> createState() => ProfileListItemViewState();
}

class ProfileListItemViewState extends State<ProfileListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // widget.items += 1;
          // _scrollDown();
          // context.read<MenuBloc>().add(MenuIndexSelected(index: 2));
        });
      },
      child: Container(
        height: 80,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.sixteen,
          ),
          color: FiicoColors.white,
        ),
        margin: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _iconView(),
            _nameView(),
            _badgeView(),
          ],
        ),
      ),
    );
  }

  Widget _iconView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
        right: FiicoPaddings.twenyFour,
        left: FiicoPaddings.twenyFour,
      ),
      child: SvgPicture.asset(
        widget.option.detail.icon,
        height: 40,
      ),
    );
  }

  Widget _nameView() {
    return Expanded(
      child: Text(
        widget.option.name,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _badgeView() {
    return Padding(
      padding: const EdgeInsets.only(right: FiicoPaddings.twenyFour),
      child: Visibility(
        visible: widget.option.detail.isActiveBadge,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            MdiIcons.bell,
          ),
        ),
      ),
    );
  }
}
