import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  final String? pathProfile;
  final Function? onProfileTap;

  Color? maskColor;
  double size = 50;

  ProfileImage({
    Key? key,
    this.pathProfile,
    this.onProfileTap,
    this.size = 50,
    this.maskColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getUserImage();
  }

  Widget getUserImage() {
    if (pathProfile == null || (pathProfile?.isEmpty ?? false)) {
      return SvgPicture.asset(
        SVGImages.userIcon,
        height: size - 5,
      );
    }

    Image profileImage;
    profileImage = Image.network(
      pathProfile!,
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
