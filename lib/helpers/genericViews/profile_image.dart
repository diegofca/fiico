import 'package:cached_network_image/cached_network_image.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  final String? pathProfile;
  final Function? onProfileTap;

  Color? maskColor;
  double size = 40;

  ProfileImage({
    Key? key,
    this.pathProfile,
    this.onProfileTap,
    this.size = 40,
    this.maskColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getUserImage();
  }

  Widget getUserImage() {
    if (pathProfile == null || (pathProfile?.isEmpty ?? false)) {
      return GestureDetector(
        onTap: () {
          onProfileTap?.call();
        },
        child: SvgPicture.asset(
          SVGImages.userIcon,
          height: size - 5,
        ),
      );
    }

    CachedNetworkImage profileImage;
    profileImage = CachedNetworkImage(
      imageUrl: pathProfile!,
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
}
