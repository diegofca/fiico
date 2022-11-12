import 'package:cached_network_image/cached_network_image.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  final FiicoUser? user;
  final Function? onProfileTap;

  Color? maskColor;
  double size = 40;

  ProfileImage({
    Key? key,
    this.user,
    this.onProfileTap,
    this.size = 40,
    this.maskColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getUserImage();
  }

  Widget getUserImage() {
    if (user?.profileImage == null || (user?.profileImage?.isEmpty ?? false)) {
      return GestureDetector(
        onTap: () {
          onProfileTap?.call();
        },
        child: _nameImage(user),
      );
    }

    CachedNetworkImage profileImage;
    profileImage = CachedNetworkImage(
      imageUrl: user!.profileImage!,
      height: size,
      width: size,
      fit: BoxFit.cover,
    );

    // Timer(Duration(seconds: 10), () {
    //   profileImage.image.evict();
    // });

    return GestureDetector(
      onTap: () {
        onProfileTap?.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size - 10,
            width: size - 10,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FiicoColors.pink,
              ),
              strokeWidth: 2,
            ),
          ),
          ClipOval(
            child: profileImage,
          ),
          ClipOval(
            child: Container(
              color: maskColor,
              height: size,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameImage(FiicoUser? user) {
    final words = (user?.userName ?? "No name").split(' ');
    String name = '';
    for (var e in words) {
      if (e.isNotEmpty && name.characters.length < 2) {
        name += e.characters.first.toString();
      }
    }

    if (name.isEmpty) {
      return SvgPicture.asset(
        SVGImages.userIcon,
        height: size - 5,
      );
    }

    return ClipOval(
      child: Container(
        color: FiicoColors.purpleSoft,
        alignment: Alignment.center,
        height: size,
        width: size,
        child: Text(
          name.toUpperCase(),
          textAlign: TextAlign.center,
          style: Style.subtitle.copyWith(
            color: FiicoColors.white,
            fontWeight: FiicoFontWeight.bold,
            fontSize: size / 3,
          ),
        ),
      ),
    );
  }
}
