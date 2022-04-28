import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/profile/model/profile_option.dart';
import 'package:flutter/material.dart';

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
      onTap: () {},
      child: Container(
        height: 60,
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
            _nameView(),
            _badgeView(),
            _arrowView(),
          ],
        ),
      ),
    );
  }

  Widget _nameView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.sixteen,
          left: FiicoPaddings.twenyFour,
        ),
        child: Text(
          widget.option.name,
          style: Style.subtitle.copyWith(
            color: FiicoColors.grayDark,
            fontSize: FiicoFontSize.xm,
          ),
        ),
      ),
    );
  }

  Widget _arrowView() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.eight,
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.keyboard_arrow_right,
          color: FiicoColors.grayDark,
        ),
      ),
    );
  }

  Widget _badgeView() {
    return SizedBox(
      width: 10,
      child: Visibility(
        visible: widget.option.isActiveBadge,
        child: IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.circle,
            color: FiicoColors.pinkRed,
            size: 10,
          ),
        ),
      ),
    );
  }
}
